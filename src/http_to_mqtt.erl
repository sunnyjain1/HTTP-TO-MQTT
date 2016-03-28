%% @doc http_to_mqtt.

-module(http_to_mqtt).
-export([start/0, stop/0]).

ensure_started(App) ->
    case application:start(App) of
        ok ->
            ok;
        {error, {already_started, App}} ->
            ok
    end.


%% @spec start() -> ok
%% @doc Start the http_to_mqtt server.
start() ->
    http_to_mqtt_deps:ensure(),
    ensure_started(crypto),
    ensure_started(inets),
    application:start(http_to_mqtt).


%% @spec stop() -> ok
%% @doc Stop the http_to_mqtt server.
stop() ->
    application:stop(http_to_mqtt).
