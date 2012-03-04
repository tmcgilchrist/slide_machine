var deckData = [{
    "title": "Webmachine Rocks!",
    "author": "Basho",
    "slides": [
      {
        "title": "Introducing Webmachine",
        "content": "Introductory material"
      },
      {
        "title": "Why?",
        "content": "Cause Erlang deserves web frameworks."
      },
      {
        "title": "Where?",
        "content": "Basho"
      }]
  }];

describe("Player", function() {

  beforeEach(function() {
    this.player = new Player();
    this.player.set('model', new Deck(deckData[0]));
  });

  describe("Player Setup", function() {
    it("creates from data", function() {
      expect(this.player.currentDeck()).toBeDefined();
    });

    it("expects slide index to start at 0", function() {
      expect(this.player.slideIndex()).toEqual(0);
    });
  });

  describe("Navigation", function () {
    it("goes to next slide", function() {
      expect(this.player.slideIndex()).toEqual(0);
      expect(this.player.get('deck')).toBeDefined();

      this.player.nextSlide();

      expect(this.player.slideIndex()).toEqual(1);
    });
  });
});
