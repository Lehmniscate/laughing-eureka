const Game = require('./game.js');
const Util = require('./util.js');

function GameView(canvasEl) {
  this.ctx = canvasEl.getContext("2d");
  this.game = new Game(canvasEl.width, canvasEl.height);
};

GameView.prototype.start = function(){
  this.bindKeyHandlers();
  setInterval( () => {
    this.game.step();
    this.draw();
  }, 20);
}

GameView.prototype.bindKeyHandlers = function() {
  key('a', () => {this.game.ship.power([-0.5,0])});
  key('w', () => {this.game.ship.power([0,-0.5])});
  key('s', () => {this.game.ship.power([0,0.5])});
  key('d', () => {this.game.ship.power([0.5,0])});
};

GameView.prototype.draw = function(){
  this.game.draw(this.ctx);
}

module.exports = GameView;
