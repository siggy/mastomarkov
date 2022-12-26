%%%-------------------------------------------------------------------
%% @doc mastomarkov public API
%% @end
%%%-------------------------------------------------------------------

-module(mastomarkov_app).

-behaviour(application).

-export([start/2, stop/1]).

-define(MASTODON_CLIENT_KEY, os:getenv("MASTODON_CLIENT_KEY")).
-define(MASTODON_CLIENT_SECRET,os:getenv("MASTODON_CLIENT_SECRET")).
-define(MASTODON_ACCESS_TOKEN,os:getenv("MASTODON_ACCESS_TOKEN")).

-define(OAUTH2_TOKEN_URL, <<"https://hachyderm.io/oauth2/token">>).

start(_StartType, _StartArgs) ->
    io:fwrite("hello, world\n"),
    io:fwrite(?MASTODON_CLIENT_KEY),
    application:ensure_all_started(oauth2c),
    application:ensure_all_started(ssl),

    % {ok, _Headers, Client} =
    %     oauth2c:retrieve_access_token(
    %       <<"client_credentials">>, ?OAUTH2_TOKEN_URL, ?CONSUMER_KEY,
    %       ?CONSUMER_SECRET),
    % {{ok, _Status1, _Headers1, Tweets}, Client2} =
    %     oauth2c:request(
    %       get, json, ?USER_TIMELINE_URL("twitterapi", "4"), [200], Client),
    % io:format("Tweets: ~p~n", [Tweets]),
    % {{ok, _Status2, _Headers2, Limits}, _Client3} =
    %     oauth2c:request(
    %       get, json, ?APP_LIMITS_URL("help,users,search,statuses"),
    %       [200], Client2),

    mastomarkov_sup:start_link().

stop(_State) ->
    ok.

%% internal functions

% Foo = os:getenv("FOO","none").

% -define(CONSUMER_SECRET, <<"my_consumer_secret">>).
% -define(CONSUMER_KEY, <<"my_consumer_key">>).

% define(PARAMETER1, os:getenv("PARAMETER1")).

% -define(OAUTH2_TOKEN_URL, <<"https://api.twitter.com/oauth2/token">>).

% -define(USER_TIMELINE_URL(User, StrCount),
%         <<"https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name="
%           , User, "&count=", StrCount>>).

% -define(APP_LIMITS_URL(Resources),
%         << "https://api.twitter.com/1.1/application/rate_limit_status.json?resources="
%            , Resources>>).
% run() ->
%     application:ensure_all_started(oauth2c),
%     application:ensure_all_started(ssl),
%     {ok, _Headers, Client} =
%         oauth2c:retrieve_access_token(
%           <<"client_credentials">>, ?OAUTH2_TOKEN_URL, ?CONSUMER_KEY,
%           ?CONSUMER_SECRET),
%     {{ok, _Status1, _Headers1, Tweets}, Client2} =
%         oauth2c:request(
%           get, json, ?USER_TIMELINE_URL("twitterapi", "4"), [200], Client),
%     io:format("Tweets: ~p~n", [Tweets]),
%     {{ok, _Status2, _Headers2, Limits}, _Client3} =
%         oauth2c:request(
%           get, json, ?APP_LIMITS_URL("help,users,search,statuses"),
%           [200], Client2),
%     io:format("Limits: ~p~n", [Limits]),
%     ok.
