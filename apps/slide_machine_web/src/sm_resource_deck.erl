-module(sm_resource_deck).
-export([init/1,
         allowed_methods/2,
         to_json/2]).

-include_lib("webmachine/include/webmachine.hrl").

-record(context, {}).

init([]) ->
    {ok, #context{}}.

allowed_methods(ReqData, State) ->
    {['HEAD', 'GET'], ReqData, State}.

to_json(ReqData, State) ->
    %% TODO Grab the data from riak
    JsonDoc = "{ deck: {
                       title: 'Webmachine Rocks!',
                       author: 'Basho',
                       slides: []
                       }
                }",
    {JsonDoc, ReqData, State}.
