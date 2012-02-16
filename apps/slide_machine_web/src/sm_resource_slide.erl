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

to_html(ReqData, State) ->
   Path = wrq:path_info(id, ReqData),

    {ok, Content} = slide_dtl:render([{param, Path}]),
    {Content, ReqData, State}.

to_json(ReqData, Context) ->
    JsonDoc = "{ slide : {
                          name: Introduction
                          content: Things
                         }
               }",
    {JsonDoc, ReqData, Context}.
