-module(http_to_mqtt_app).
-author("Mochi Media <dev@mochimedia.com>").

-behaviour(application).
-export([start/2,stop/1]).


%% @spec start(_Type, _StartArgs) -> ServerRet
%% @doc application start callback for http_to_mqtt.
start(_Type, _StartArgs) ->
    http_to_mqtt_deps:ensure(),
    http_to_mqtt_sup:start_link().

%% @spec stop(_State) -> ServerRet
%% @doc application stop callback for http_to_mqtt.
stop(_State) ->
    ok.
