-module(slide_machine_core).
-author('Tim McGilchrist <timmcgil@gmail.com>').
-export([start/0, start_link/0, stop/0]).

start_link() ->
    common_start(),
    slide_machine_core_sup:start_link().

start() ->
    common_start(),
    application:start(slide_machine_core).

stop() ->
    Res = application:stop(slide_machine_core),
    application:stop(pooler),
    application:stop(crypto),
    Res.

ensure_started(App) ->
    case application:start(App) of
        ok ->
            ok;
        {error, {already_started, App}} ->
            ok
    end.

common_start() ->
    ensure_started(crypto),
    ensure_started(pooler).
