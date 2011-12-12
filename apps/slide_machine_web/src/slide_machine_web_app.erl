%% @author author <author@example.com>
%% @copyright YYYY author.

%% @doc Callbacks for the slide_machine_web application.

-module(slide_machine_web_app).
-author('author <author@example.com>').

-behaviour(application).
-export([start/2,stop/1]).


%% @spec start(_Type, _StartArgs) -> ServerRet
%% @doc application start callback for slide_machine_web.
start(_Type, _StartArgs) ->
    slide_machine_web_sup:start_link().

%% @spec stop(_State) -> ServerRet
%% @doc application stop callback for slide_machine_web.
stop(_State) ->
    ok.
