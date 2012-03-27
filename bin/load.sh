#! /bin/bash

curl -v -X POST -d "{title: 'WebMachine', author: 'Basho', summary: 'Webmachine is a toolkit for building RESTful web applications.', slides: [{title: 'Introducing Webmachine', content: 'Introductory material'}, {title: 'Why?', content: 'Cause Erlang deserves more web frameworks.'}, {title: 'Where?', content: 'Basho'}]}" -H "Content-Type: application/json" http://127.0.0.1:8098/riak/decks/webmachine

curl -v -X POST -d "{title: 'Jasmine for the testing', author: 'Pivotal Labs', summary: 'Jasmine is a TDD style framework influenced by rspec', slides: [{title: 'Jasmine One', content: 'One Jasmine'}]}" -H "Content-Type: application/json" http://127.0.0.1:8098/riak/decks/jasmine
