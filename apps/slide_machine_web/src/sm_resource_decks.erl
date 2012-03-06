-module(sm_resource_decks).
-export([init/1,
         allowed_methods/2,
         to_html/2,
         to_json/2]).

-include_lib("webmachine/include/webmachine.hrl").

-record(context, {}).

init([]) ->
    {ok, #context{}}.

allowed_methods(ReqData, State) ->
    {['HEAD', 'GET'], ReqData, State}.


to_html(ReqData, State) ->
    to_json(ReqData, State).

to_json(ReqData, State) ->
    JsonDoc = "[{ \"title\": \"Webmachine Rocks!\",
                  \"author\": \"Basho\",
                  \"summary\": \"Webmachine is a toolkit for building RESTful web applications.\",
                  \"slides\": [ {
                    \"title\": \"Introducing Webmachine\",
                    \"content\": \"Introductory material\"
                  }, {
                    \"title\": \"Why?\",
                    \"content\": \"Cause Erlang deserves web frameworks.\"
                  }, {
                    \"title\": \"Where?\",
                    \"content\": \"Basho\"
                  }]
                },{
                  \"title\": \"Jasmine for the testing\",
                  \"author\": \"Pivotal Labs\",
                  \"summary\": \"Jasmine is a TDD style framework influenced by rspec.\",
                  \"slides\": []
                }]",
    {JsonDoc, ReqData, State}.
