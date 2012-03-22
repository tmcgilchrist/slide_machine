-module(sm_resource_decks).
-export([init/1,
         allowed_methods/2,
         content_types_provided/2,
         to_json/2,
        finish_request/2]).

-include_lib("webmachine/include/webmachine.hrl").

-record(context, {db}).

init([]) ->
    {ok,{}}.

allowed_methods(ReqData, State) ->
    {['HEAD', 'GET'], ReqData, State}.

content_types_provided(ReqData, State) ->
    {[{"application/json", to_json}], ReqData, State}.

to_json(ReqData, State) ->
    %% Load key from arguments
    %% Call slide_machine_core to grab the data.
    case wrq:path_info(id, ReqData) of
        undefined ->
            % Return all decks
            All = "[{ title: 'Webmachine Rocks!', author: 'Basho',
                      summary: 'Webmachine is a toolkit for building RESTful web applications.',
                      slides: [ { title: 'Introducing Webmachine', content: 'Introductory material' },
                                { title: 'Why?', content: 'Cause Erlang deserves web frameworks.'   },
                                { title: 'Where?', content: 'Basho' }] },
                    { title: 'Jasmine for the testing', author: 'Pivotal Labs',
                      summary: 'Jasmine is a TDD style framework influenced by rspec.',
                      slides: []
                    }
                   ]",
            {All, ReqData, State};
        _ID ->
            % Find a deck by id
            JsonDoc = "[{title: 'Webmachine', author: 'George', summary: 'Webmachine plus George is unstoppable.'}]",
            {JsonDoc, ReqData, State}
    end.

finish_request(ReqData, State) ->
    {true, ReqData, State}.
