ERL ?= erl
APP := slide_machine_web

RIAK_DIR=./riak-1.1.1/

.PHONY: deps

all: deps
	@./rebar compile

app:
	@./rebar compile skip_deps=true

deps:
	@./rebar get-deps

clean:
	@./rebar clean

distclean: clean
	@./rebar delete-deps

test: all
	@./rebar eunit skip_deps=true

webstart: app
	exec erl -pa $(PWD)/apps/*/ebin -pa $(PWD)/deps/*/ebin -boot start_sasl -config $(PWD)/apps/slide_machine_core/priv/app.config -s reloader -s slide_machine_core -s slide_machine_web

docs:
	@erl -noshell -run edoc_run application '$(APP)' '"."' '[]'

riak_start:
	$(RIAK_DIR)bin/riak start

riak_stop:
	$(RIAK_DIR)bin/riak stop

setup_node:
	mkdir rel
	cd rel && ../rebar create-node node=slide_machine
