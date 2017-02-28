const Board = require('./board.js');

class View {
  constructor($rootEl) {
    this.$rootEl = $rootEl;
    this.board = new Board();
    this.setupBoard();
    this.bindKeys();
    let self = this;
    let callback = function () {
      self.step(self);
    };
    this.intervalId = window.setInterval(callback, 100);
    this.render();
  }

  step(view) {
    view.board.move();
    view.render();
    if (this.board.gameOver) { window.clearInterval(this.intervalId); alert("YOU LOSE!"); }
  }

  render() {
    $("li").each(function() { $( this ).attr("class", "cell");});

    let segments = this.board.snake.segments;
    console.log(`snake is ${segments.length} long`);
    for (var i = 0; i < segments.length; i++) {
      console.log(`${i} : ${segments[i][0]} , ${segments[i][1]}`);
      $("ul").eq(segments[i][0]).children().eq(segments[i][1]).addClass("segment");
    }

    $("ul").eq(this.board.apple[0]).children().eq(this.board.apple[1]).addClass("apple");

  }

  setupBoard() {
    for(var i = 0; i < this.board.dimension; i++) {
      var $ul = $("<ul></ul>");
      $ul.data("row", i);
      $ul.addClass("row");
      for(var j = 0; j < this.board.dimension; j++) {
        var $li = $("<li></li>");
        $li.addClass("cell");
        $li.data("row", i);
        $li.data("col", j);
        $ul.append($li);
      }
      this.$rootEl.append($ul);
    }
  }

  bindKeys() {
    let self = this;
    $('body').on("keydown", function(event) {self.turn(event.keyCode);});
  }

  turn(keyCode) {
    switch (keyCode) {
      case 37:
        this.board.turn("W");
        break;
      case 38:
        this.board.turn("N");
        break;
      case 39:
        this.board.turn("E");
        break;
      case 40:
        this.board.turn("S");
        break;
      default:

    }
  }
}

module.exports = View;
