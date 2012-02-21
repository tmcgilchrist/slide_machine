(function($) {

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

  window.Decks = Backbone.Collection.extend({
    model: Deck,
    url: '/decks'
  });

  window.DeckView = Backbone.View.extend({
    tagName: 'li',
    className: 'deck',


    initialize: function() {
      _.bindAll(this, 'render');
      this.model.bind('change', this.render);
      this.template = _.template($('#deck-template').html());
    },

    render: function() {
      var renderedContent = this.template(this.model.toJSON());
      $(this.el).html(renderedContent);
      return this;
    }
  });

})(jQuery);
