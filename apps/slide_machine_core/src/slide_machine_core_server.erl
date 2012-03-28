-module(slide_machine_core_server).
-behaviour(gen_server).
-define(SERVER, ?MODULE).

-define(BUCKET, <<"decks">>).

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
handle_call({find_deck, Key}, _From, State) ->
    {ok, RiakObj} = pooler:use_member(fun(RiakPid) ->
                                              riakc_pb_socket:get(RiakPid, ?BUCKET, Key)
                                      end),
    JsonDoc = riakc_obj:get_value(RiakObj),
    {reply, {found_deck, JsonDoc}, State};

handle_call({find_all_decks}, _From, State) ->
    {ok, All} = pooler:use_member(fun(RiakPid) ->
                                    find_all(RiakPid)
                            end),
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

find_all(RiakPid) ->
    {ok, Keys} = riakc_pb_socket:list_keys(RiakPid, ?BUCKET),
    {ok, find(Keys, RiakPid)}.

find([Key|Keys], RiakPid) ->
    {ok, Obj} = riakc_pb_socket:get(RiakPid, ?BUCKET, Key),
    Json = riakc_obj:get_value(Obj),
    [Json | find(Keys, RiakPid)];
find([], _Pid) ->
    [].
