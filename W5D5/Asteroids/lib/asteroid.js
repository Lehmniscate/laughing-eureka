const MovingObject = require('./moving_object.js');
const Ship = require('./ship.js');
const Bullet = require('./bullet.js');
const Util = require('./util.js');

function Asteroid(position, game) {
  const COLOR = "#999999";
  const RADIUS = 50;
  MovingObject.call(this, {
    vel: Util.randomVec(2),
    pos: position,
    color: COLOR,
    radius: RADIUS,
    game: game
  })
};

Util.inherits(Asteroid, MovingObject);

Asteroid.prototype.collideWith = function(otherObject){
  if(otherObject instanceof Ship) {
    otherObject.relocate();
  }
};

module.exports = Asteroid;
