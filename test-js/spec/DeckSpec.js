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
  }, {
    "title": "Jasmine FTW",
    "author": "Pivotal Labs",
    "slides": [
      {
        "title": "What is jasmine?",
        "content": "Jasmine is a javascript testing framework"
      }
    ]
}];


describe("Deck", function() {

  beforeEach(function() {
    this.deck = new Deck(deckData[0]);
  });

  it("creates from data", function () {
    expect(this.deck.get('slides').length).toEqual(3);
  });

  describe("first slide", function() {
    it("identifies correct first slide", function() {
      expect(this.deck.isFirstSlide(0)).toBeTruthy();
    });
  });

  describe("last slide", function() {
    it("identifies the last slide", function() {
      expect(this.deck.isLastSlide(2)).toBeTruthy();
    });
  });

  it("returns the contents of a slide", function() {
    expect(this.deck.slideContentsAtIndex(0)).toEqual('Introductory material');
  });
});
