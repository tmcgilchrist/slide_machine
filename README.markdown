## Simple Webmachine / Riak application for presenting slides

This is very much a work in progress and as such might not be useful for anybody
at all.

#### Resources:

* slide => individual slide authored in markdown?
* deck  => collection of slides with an implied ordering.
* library => collection of all decks
* author => author of a particular deck of slides

#### TODO
* start with modeling a basic slide and presenting it using backbone.js and
  html.
* backbone.js UI presenting a deck
* riak storage of slides
* webmachine rest interface to the resources, slide and deck
* backbone.js UI presenting a library


### Layout

slide_machine_web
 -> deps - the erlang library dependencies for the web application
 -> ebin - compiled beam files for the erlang VM
 -> src  - Erlang source code
 -> priv - is where all the html and Javascript files are placed.
