-module(slide_machine_core_server).
-behaviour(gen_server).
-define(SERVER, ?MODULE).

%% ------------------------------------------------------------------
%% API Function Exports
%% ------------------------------------------------------------------

-export([start_link/0, find_deck/1, find_all_decks/0]).

%% ------------------------------------------------------------------
%% gen_server Function Exports
%% ------------------------------------------------------------------

-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

%% ------------------------------------------------------------------
%% API Function Definitions
%% ------------------------------------------------------------------

start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

find_deck(Id) ->
    gen_server:call(?SERVER, {find_deck, Id}, infinity).

find_all_decks() ->
    gen_server:call(?SERVER, {find_all_decks}, infinity).

%% ------------------------------------------------------------------
%% gen_server Function Definitions
%% ------------------------------------------------------------------

init(Args) ->
    {ok, Args}.

% Handle a find_deck :id
handle_call({find_deck, Id}, _From, State) ->
    io:format("find_deck ~p\n", [Id]),
    JsonDoc = "[{title: 'Webmachine', author: 'George', summary: 'Webmachine plus George is unstoppable.'}]",
    {reply, {found_deck, JsonDoc}, State};

handle_call({find_all_decks}, _From, State) ->
    io:format("find_all_decks\n", []),
    All = "[{ title: 'Webmachine Rocks!', author: 'Basho',
              summary: 'Webmachine is a toolkit for building RESTful web applications.',
              slides: [ { title: 'Introducing Webmachine', content: 'Introductory material' },
                        { title: 'Why?', content: 'Cause Erlang deserves web frameworks.'   },
                        { title: 'Where?', content: 'Basho' }] },
            { title: 'Jasmine for the testing', author: 'Pivotal Labs',
              summary: 'Jasmine is a TDD style framework influenced by rspec.',
              slides: []
            }]",
    {reply, {found_all_decks, All}, State};

handle_call(_Request, _From, State) ->
    {noreply, ok, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% ------------------------------------------------------------------
%% Internal Function Definitions
%% ------------------------------------------------------------------
