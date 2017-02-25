const Util = require('./util.js');

function MovingObject(opts) {
  Object.keys(opts).forEach(k => this[k] = opts[k]);
};

MovingObject.prototype.move = function() {
  this.pos[0] += this.vel[0];
  this.pos[1] += this.vel[1];
  this.pos = this.game.wrap(this.pos);
};

MovingObject.prototype.draw = function(ctx) {
  ctx.fillStyle = this.color;
  ctx.beginPath();
  ctx.arc(
    ...this.pos,
    this.radius,
    0, 2 * Math.PI
  );
  ctx.fill();
};

MovingObject.prototype.collideWith = function(otherObject){};

MovingObject.prototype.isCollidedWith = function(otherMovingObject) {
  let distance = Util.distance(this.pos, otherMovingObject.pos);
  return distance < (this.radius + otherMovingObject.radius);
};

module.exports = MovingObject;
