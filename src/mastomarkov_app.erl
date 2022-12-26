%%%-------------------------------------------------------------------
%% @doc mastomarkov public API
%% @end
%%%-------------------------------------------------------------------

-module(mastomarkov_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    io:fwrite("hello, world\n"),
    mastomarkov_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
