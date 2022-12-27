%%%-------------------------------------------------------------------
%% @doc mastomarkov public API
%% @end
%%%-------------------------------------------------------------------

-module(mastomarkov_app).

-behaviour(application).

-export([start/2, stop/1]).

-define(MASTODON_HOST, os:getenv("MASTODON_HOST")).
-define(MASTODON_ACCESS_TOKEN, os:getenv("MASTODON_ACCESS_TOKEN")).

start(_StartType, _StartArgs) ->
    io:fwrite("starting\n"),

    application:ensure_all_started(ssl),
    application:ensure_all_started(inets),

    io:fwrite("retrieving home timeline...\n"),
    % curl -H "Authorization: Bearer $MASTODON_ACCESS_TOKEN" https://$MASTODON_HOST/api/v1/timelines/home

    Url = "https://" ++ ?MASTODON_HOST ++ "/api/v1/timelines/home",
    AuthHeader = {"Authorization", "Bearer " ++ ?MASTODON_ACCESS_TOKEN},

    {ok, {{Version, 200, ReasonPhrase}, Headers, Body}} =
        httpc:request(get,
                    {Url, [AuthHeader]},
                    [],
                    []),
    io:format("~s\n\n", [Body]),

    io:fwrite("posting an update...\n"),
    % curl -X POST -H "Authorization: Bearer $MASTODON_ACCESS_TOKEN" -F 'status=First post from API' https://$MASTODON_HOST/api/v1/statuses

    UrlPost = "https://" ++ ?MASTODON_HOST ++ "/api/v1/statuses",
    {Mega,Sec,Micro} = erlang:now(),
    BodyPost = "status=Post from API: " ++ integer_to_list(Mega) ++ "." ++ integer_to_list(Sec) ++ "." ++ integer_to_list(Micro),
    {ok, {{VersionPost, 200, ReasonPhrasePost}, HeadersPost, BodyResp}} =
        httpc:request(post,
                    {UrlPost, [AuthHeader], "multipart/form-data", BodyPost},
                    [],
                    []),
    io:format("~s\n\n", [BodyResp]),

    mastomarkov_sup:start_link().

stop(_State) ->
    ok.
