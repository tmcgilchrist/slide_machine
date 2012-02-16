## Simple Webmachine / Riak application for presenting slides

This is very much a work in progress and as such might not be useful for anybody
at all.

#### Resources:

* slide => individual slide authored in markdown?
* deck  => collection of slides with an implied ordering.
* library => collection of all decks
* author => author of a particular deck of slides

#### TODO
* try out ErlyDTL for templating html resources.
* provided basic slide resource and getting passed in the id eg /slide/[:id]
  next step is to build a riak backend to retrieve data from.

slide
    id
    contents/json
    next/link
    previous/link

{ slide : {
    name: String
    content : { json }
    }
}

* need way of packaging javascript
* start with modeling a basic slide and presenting it using backbone.js and
  html.
* backbone.js UI presenting a deck
* riak storage of slides
* webmachine rest interface to the resources, slide and deck
* backbone.js UI presenting a library
*

### BUGS: (Not that there are any)

* /slide/id works but want /slide to fail more gracefully.


### Layout
You should find in this directory:

    README.markdown : this file
    Makefile : simple make commands
    rebar : the Rebar build tool for Erlang applications
    rebar.config : configuration for Rebar
    apps : Erlang modules that make up this application
    /slide_machine_web : webmachine application
      /deps - the erlang library dependencies for the web application
      /ebin - compiled beam files for the erlang VM
      /src  - Erlang source code
      /priv - is where all the html and Javascript files are placed.
    /slide_machine_core : core logic to mediate between web app and riak db
      /deps - the erlang library dependencies
      /ebin - compiled beam files for the erlang VM
      /src  - Erlang source code

### Helpful Resources
 * [CloudEdit Backbone.js tutorial](http://www.jamesyu.org/2011/01/27/cloudedit-a-backbone-js-tutorial-by-example/)
 * [CloudEdit with Erlang and Webmachine P1](http://blog.erlware.org/2011/02/08/ecloudedit-erlang-webmachine-and-backbone-js/)
 * [CloudEdit with Erlang and Webmachine P2](http://blog.erlware.org/2011/02/12/ecloudedit-part-2-couchdb/)
 * [Webmachine, ErlyDTL and Riak by OJ](http://buffered.io/2010/10/13/webmachine-erlydtl-and-riak-part-3/)
