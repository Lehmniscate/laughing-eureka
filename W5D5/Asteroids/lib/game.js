const Asteroid = require('./asteroid.js');
const Bullet = require('./bullet.js');
const Ship = require('./ship.js');
const Util = require('./util.js');

function Game(width, height) {
  this.dimX = width;
  this.dimY = height;
  this.numAsteroids = Math.ceil((width * height) / 150000);
  this.asteroids = [];
  this.ship = new Ship(this);
  this.bullets = [];
  this.addAsteroids();
};

Game.prototype.allObjects = function() {
  return this.asteroids.concat(this.bullets).concat(this.ship);
}

Game.prototype.addAsteroids = function() {
  for(var i = 0; i < this.numAsteroids; i++) {
    this.asteroids.push(new Asteroid(this.randomPosition(), this));
  }
};

Game.prototype.wrap = function(pos){
  let arr = [this.dimX + 100, this.dimY + 100];
  pos = [pos[0] + 50, pos[1] + 50]

  for (var i = 0; i < 2; i++) {
    if (pos[i] < 0){
      pos[i] = arr[i] + pos[i];
    } else {
      pos[i] = pos[i] % arr[i];
    }
  }

  return [pos[0] - 50, pos[1] - 50];
};

Game.prototype.randomPosition = function() {
  return [this.dimX * Math.random(), this.dimY * Math.random()];
};

Game.prototype.moveObjects = function() {
  this.allObjects().forEach(a => a.move());
};

Game.prototype.step = function() {
  this.moveObjects();
  this.checkCollisions();
};

Game.prototype.remove = function(asteroid) {
  let i = this.asteroids.indexOf(asteroid);
  this.asteroids.splice(i, 1);
}

Game.prototype.checkCollisions = function() {
  for(var i = 0; i < this.allObjects().length; i++) {
    for(var j = 0; j < this.allObjects().length; j++) {
      if(i === j) continue;
      if(this.allObjects()[i].isCollidedWith(this.allObjects()[j])){
        this.allObjects()[i].collideWith(this.allObjects()[j]);
      }
    }
  }
};

Game.prototype.draw = function(ctx) {
  ctx.clearRect(0,0,this.dimX, this.dimY);
  this.allObjects().forEach(a => a.draw(ctx));
};

module.exports = Game;
