class View {
  constructor(game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupBoard();
    this.bindEvents();
  }

  bindEvents() {
    let self = this;
    $('ul').on("click", "li", function()
      { self.makeMove($(this));}
      );
  }

  makeMove($square) {
    let id = $square.data("id");

    if($square.attr("class") !== "emptySquare") return;

    $square.removeClass("emptySquare");
    $square.addClass(`${this.game.currentPlayer}`);
    $square.text(`${this.game.currentPlayer.toUpperCase()}`);
    this.game.playMove([Math.floor(id / 3), id % 3]);
    if(this.game.isOver()) {
      if (this.game.winner()) {
        alert(`${this.game.winner().toUpperCase()} has won!`);
      } else {
        alert('NO ONE WINS!');
      }
    }
  }

  setupBoard() {
    let $ul = $("<ul></ul>");
    $ul.addClass("grid");
    for(var i = 0; i < 9; i++) {
      let $li = $("<li></li>");
      $li.addClass("emptySquare");
      $li.data("id", i);
      $ul.append($li);
    }
    this.$el.append($ul);
  }
}

module.exports = View;
