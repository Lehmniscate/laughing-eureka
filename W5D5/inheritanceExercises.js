// --------------------------------------------------------------------
//                    inherits
// --------------------------------------------------------------------
Function.prototype.inherits = function(parent) {
  function Surrogate () {};
  Surrogate.prototype = parent.prototype;
  this.prototype = new Surrogate();
  this.prototype.constructor = this;
};

function MovingObject() {
  this.name = "hi";
  this.move = function() {
    console.log("I'm moving!");
  }
};

MovingObject.prototype.move2 = function() {
  console.log("I'm moving again!");
}

function Ship () {
  MovingObject.call(this);
  this.float = function() {
    console.log("Just floating along");
  }
};
Ship.inherits(MovingObject);

function Asteroid () {
  MovingObject.call(this);
  this.float = function() {
    console.log("I'm a rock");
  }

  this.fly = function() {
    console.log("Just flying along");
  }
};
Asteroid.inherits(MovingObject);

let ship = new Ship();
let asteroid = new Asteroid();
let movingObject = new MovingObject();

movingObject.move();
asteroid.move();
ship.move();
ship.move2();
asteroid.float();
ship.float();

asteroid.fly();
