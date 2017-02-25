const MovingObject = require('./moving_object.js');
const Util = require('./util.js');

function Ship(game) {
  const COLOR = "#000000";
  const RADIUS = 5;
  MovingObject.call(this, {
    vel: [0,0],
    pos: [(game.dimX / 2), (game.dimY / 2)],
    color: COLOR,
    radius: RADIUS,
    game: game
  })
};

Util.inherits(Ship, MovingObject);

Ship.prototype.power = function(impulse) {
  this.vel[0] += impulse[0];
  this.vel[1] += impulse[1];
};

Ship.prototype.relocate = function() {
  this.pos = this.game.randomPosition();
  this.vel = [0,0];
};

module.exports = Ship;
