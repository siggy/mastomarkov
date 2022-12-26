mastomarkov
=====

An OTP application

Build
-----

    $ rebar3 compile





# mastodon-markov


https://docs.joinmastodon.org/spec/oauth/

https://github.com/kivra/oauth2

https://github.com/erlangpack/erlang-oauth

https://medium.com/erlang-central/building-your-first-erlang-app-using-rebar3-25f40b109aad

```bash
sudo apt-get install libncurses5-dev libncursesw5-dev


wget https://erlang.org/download/otp_src_R16B03-1.tar.gz
tar xvfz https://erlang.org/download/otp_src_R16B03-1.tar.gz
cd otp_src_R16B03-1

./configure && make && make install
```

```bash


https://github.com/kivra/oauth2_client


```

```bash
kerl build 25.2 25.2-libssl
kerl install 25.2-libssl /home/sig/kerl/25.2-libssl


. /home/sig/kerl/25.2/activate
. /home/sig/kerl/25.2-libssl/activate


rebar3 new app mastomarkov
cd mastomarkov
rebar3 compile

rebar3 hex user auth


rebar3 shell
application:start(myapp).
application:stop(myapp).

```
