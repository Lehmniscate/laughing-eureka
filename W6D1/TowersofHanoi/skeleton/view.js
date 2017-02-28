
class HanoiView {
  constructor(game, $el) {
    this.numbers = ["zero", "one", "two", "three"];
    this.clicked = -1;
    this.game = game;
    this.$el = $el;
    this.setupTowers();
    this.bindEvents();
    this.render();
  }

  bindEvents() {
    let self = this;
    $('ul').each((index) => {
      $('ul').eq(index).on("click", function() {
        self.makeMove( $(this) );
      });
    });
  }

  makeMove($tower) {

    let tower = $tower.data("id");

    if(this.clicked !== -1) {
      if(this.game.isValidMove(this.clicked, tower)) {
        this.game.move(this.clicked, tower);
      }
      this.clicked = -1;
    } else {
      this.clicked = tower;
    }

    this.render();
    setTimeout(() => {
      if(this.game.isWon()) alert("Congratulations!");}, 100);
  }

  setupTowers() {
    let $ul1 = $("<ul></ul>");
    let $ul2 = $("<ul></ul>");
    let $ul3 = $("<ul></ul>");

    let $ul = [$ul1, $ul2, $ul3];
    for (var j = 0; j < 3; j++) {
      $ul[j].addClass("tower");
      $ul[j].data("id", j);
      for(var i = 0; i < 3; i++) {
        let $li = $("<li></li>");
        $li.addClass("emptyDisc");
        $li.data("id", i);
        $ul[j].append($li);
      }
    this.$el.append($ul[j]);
    }
  }

  render() {
    $("li").each(function() { $( this ).attr("class", "emptyDisc");});
    $("ul").each(function() { $( this ).attr("class", "tower");});

    let towers = this.game.towers;
    for (let i = 0; i < towers.length; i++) {
      if(this.clicked === i) $('ul').eq(i).addClass("selected");
      towers[i].forEach( disc => {
        $("ul").eq(i).children(".emptyDisc").last().attr("class", `${this.numbers[disc]}`) ;
      });
    }
  }
}

module.exports = HanoiView;
