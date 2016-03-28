%% @doc Web server for http_to_mqtt.

-module(http_to_mqtt_web).
-import(proplists,[get_value/2,get_value/3]).
-export([start/1, stop/0, loop/2]).

%% External API

start(Options) ->
    {DocRoot, Options1} = get_option(docroot, Options),
    Loop = fun (Req) ->
                   ?MODULE:loop(Req, DocRoot)
           end,
    mochiweb_http:start([{name, ?MODULE}, {loop, Loop} | Options1]).

stop() ->
    mochiweb_http:stop(?MODULE).

loop(Req, DocRoot) ->
    "/" ++ Path = Req:get(path),
    try
        case Req:get(method) of
            Method when Method =:= 'GET'; Method =:= 'HEAD' ->
                case Path of
                  "hello_world" ->
                    Req:respond({200, [{"Content-Type", "text/plain"}],
                    "Hello world!\n"});
                    _ ->
                        Req:serve_file(Path, DocRoot)
                end;
            'POST' ->
                case Path of
                    _ ->
						Data = mochiweb_request:parse_post(Req),
						{RegisterFun,PublishFun,SubscribeFun} = vmq_reg:direct_plugin_exports(http_to_mqtt),
						Topic    = get_value("topic", Data),
						List_of_topics = string:tokens(Topic, "/"),
						Lot = lists:map(fun(X) -> list_to_binary(X) end, List_of_topics),
						Payload  = list_to_binary(get_value("message", Data)),
						Qos = erlang:list_to_integer(get_value("qos",Data)),
						Retain = erlang:list_to_integer(get_value("retain",Data)),
						error_logger:info_msg("Topics: ~p~nPayload: ~p~nQOS: ~p~nRetain: ~p",[Lot, Payload,Qos,Retain]),
						PublishFun(Lot,Payload,#{qos => Qos, retain => Retain}),
						Req:ok({"text/html", [], "<p>Thank you. <p>"})

                end;
            _ ->
                Req:respond({501, [], []})
        end
    catch
        Type:What ->
            Report = ["web request failed",
                      {path, Path},
                      {type, Type}, {what, What},
                      {trace, erlang:get_stacktrace()}],
            error_logger:error_report(Report),
            Req:respond({500, [{"Content-Type", "text/plain"}],
                         "request failed, sorry\n"})
    end.

%% Internal API

get_option(Option, Options) ->
    {proplists:get_value(Option, Options), proplists:delete(Option, Options)}.
