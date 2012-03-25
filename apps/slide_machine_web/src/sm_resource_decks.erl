-module(sm_resource_decks).
-export([init/1,
         allowed_methods/2,
         content_types_provided/2,
         to_json/2,
        finish_request/2]).

-include_lib("webmachine/include/webmachine.hrl").

-record(state, {}).

init([]) ->
    {ok, #state{}}.

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
            {found_all_decks, JsonDoc} = slide_machine_core_server:find_all_decks(),
            {JsonDoc, ReqData, State};
        Id ->
            % Find a deck by id
            {found_deck, JsonDoc} = slide_machine_core_server:find_deck(Id),
            {JsonDoc, ReqData, State}
    end.

finish_request(ReqData, State) ->
    {true, ReqData, State}.
