-module(sm_resource_slide).
-export([init/1,
         allowed_methods/2,
        to_html/2,
        to_json/2]).

-include_lib("webmachine/include/webmachine.hrl").

-record(context, {}).

init([]) ->
    {ok, #context{}}.

allowed_methods(ReqData, Context) ->
    {['HEAD', 'GET'], ReqData, Context}.

to_html(ReqData, Context) ->
    Path = wrq:path_info(id, ReqData),
    Html = io_lib:format("<html><body><h1>slide</h1><h2>Introduction</h2><p>Things</p><p>~s</p></body></html>", [Path]),
    {Html, ReqData, Context}.

to_json(ReqData, Context) ->
    JsonDoc = "{ slide : {
                          name: Introduction
                          content: Things
                         }
               }",
    {JsonDoc, ReqData, Context}.
