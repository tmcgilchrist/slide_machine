(function($) {

  window.Presentation = Backbone.Model.extend({});

  window.PresentationView = Backbone.View.extend({
    tagName: 'li',
    className: 'presentation',


    initialize: function() {
      _.bindAll(this, 'render');
      this.model.bind('change', this.render);
      this.template = _.template($('#presentation-template').html());
    },

    render: function() {
      var renderedContent = this.template(this.model.toJSON());
      $(this.el).html(renderedContent);
      return this;
    }
  });

})(jQuery);
