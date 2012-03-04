(function($) {

  //--------------------------------------------------------------
  //         Models
  //--------------------------------------------------------------
  window.Deck = Backbone.Model.extend({
    isFirstSlide: function(index) {
      return index == 0;
    },

    isLastSlide: function(index) {
      return index >= this.get('slides').length - 1 ;
    },

    slideContentsAtIndex: function(index) {
      if (this.get('slides').length >= index) {
        return this.get('slides')[index].content;
      }
      return null;
    }
  });


  window.Player = Backbone.Model.extend({
    defaults: {
      slideIndex: 0,
      deck: 0
    },

    currentDeck: function() {
      return this.get('deck');
    },

    slideIndex: function() {
      return this.get('slideIndex');
    },

    nextSlide: function() {
      var deck = this.currentDeck();
      if (deck && deck.isLastSlide()) {
        this.set('slideIndex', 0);
      } else {
        this.set('slideIndex', this.slideIndex() + 1);
      }
    },

  });

  //--------------------------------------------------------------
  //         Collections
  //--------------------------------------------------------------
  window.Decks = Backbone.Collection.extend({
    model: Deck,
    url: '/decks'
  });

  window.Playlist = Decks.extend({
  });

  window.library = new Decks();
  window.player = new Player();

  //--------------------------------------------------------------
  //         Views
  //--------------------------------------------------------------
  window.DeckView = Backbone.View.extend({
    tagName: 'li',
    className: 'deck',

    initialize: function() {
      _.bindAll(this, 'render');
      this.model.bind('change', this.render);
      this.template = _.template($('#deck-thumbnail-template').html());
    },

    render: function() {
      $(this.el).html(this.template(this.model.toJSON()));
      return this;
    }
  });

  window.LibraryDeckView = DeckView.extend({
    events: {
      'click .queue.add': 'select'
    },

    select: function() {
      this.collection.trigger('select', this.model);
    }
  });

  window.LibraryView = Backbone.View.extend({
    tagName: 'section',
    className: 'library',

    initialize: function() {
      _.bindAll(this, 'render');
      this.template = _.template($('#library-template').html());
      this.collection.bind('reset', this.render);
    },

    render: function() {
      var $decks,
          collection = this.collection;

      $(this.el).html(this.template({}));
      $decks = this.$('.decks');
      collection.each(function(deck) {
        var view = new LibraryDeckView({
          model: deck,
          collection: collection
        });
        $decks.append(view.render().el);
      });
      return this;
    }
  });


  window.PlaylistDeckView = Backbone.View.extend({
    tag: 'div',
    className: 'deck-info',

    initialize: function() {
      _.bindAll(this, 'render');

      this.deck   = this.options.deck;
      this.template = _.template($('#deck-info-template').html());
    },

    render: function() {
      $(this.el).html(this.template(this.deck.toJSON()));
      return this;
    }
  });

  window.PlaylistView = Backbone.View.extend({
    tag: 'section',
    className: 'playlist', //add css for this element

    initialize: function() {
      _.bindAll(this, 'render', 'queueDeck', 'renderDeck');
      this.template = _.template($ ('#playlist-template').html());

      this.player = this.options.player;
      this.player.bind('change', this.renderDeck);

      this.library = this.options.library;
      this.library.bind('select', this.queueDeck);
    },

    render: function() {
      $(this.el).html(this.template(this.player.toJSON()));
      return this;
    },

    renderDeck: function(deck) {
      var view = new PlaylistDeckView({
        deck: this.player.currentDeck()
      });
      this.$('div').append(view.render().el);
    },

    queueDeck: function(deck) {
      this.player.set('deck', deck);
    }
  });


  //--------------------------------------------------------------
  //         Routers
  //--------------------------------------------------------------
  window.BackboneDecks = Backbone.Router.extend({
    routes: {
      '': 'home'
    },

    initialize: function() {
      this.playlistView = new PlaylistView({
        collection: window.player.playlist,
        player:     window.player,
        library:    window.library
      });

      this.libraryView = new LibraryView({
        collection: window.library
      });
    },

    home: function() {
      var $container = $('#container');
      $container.empty();
      $container.append(this.playlistView.render().el);
      $container.append(this.libraryView.render().el);
    }
  });

  $(function() {
    window.App = new BackboneDecks();
    Backbone.history.start();
  });

})(jQuery);
