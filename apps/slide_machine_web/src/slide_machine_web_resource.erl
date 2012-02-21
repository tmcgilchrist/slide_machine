-module(slide_machine_web_resource).
-export([init/1,
         allowed_methods/2,
         to_html/2]).

-include_lib("webmachine/include/webmachine.hrl").

init([]) -> {ok, undefined}.

allowed_methods(ReqData, State) ->
    {['HEAD', 'GET'], ReqData, State}.

to_html(ReqData, State) ->
    {ok, Content} = index_dtl:render([]),
    {Content, ReqData, State}.
