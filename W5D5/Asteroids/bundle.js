/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	const GameView = __webpack_require__(1)

	const canvasEl = document.getElementsByTagName("canvas")[0];
	canvasEl.height = window.innerHeight;
	canvasEl.width = window.innerWidth;
	let gv = new GameView(canvasEl);
	gv.start();


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	const Game = __webpack_require__(2);
	const Util = __webpack_require__(5);

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
	  key(' ', () => {alert("SPACE")});
	  key('a', () => {this.game.ship.power([-0.5,0])});
	  key('w', () => {this.game.ship.power([0,-0.5])});
	  key('s', () => {this.game.ship.power([0,0.5])});
	  key('d', () => {this.game.ship.power([0.5,0])});
	};

	GameView.prototype.draw = function(){
	  this.game.draw(this.ctx);
	}

	module.exports = GameView;


/***/ },
/* 2 */
/***/ function(module, exports, __webpack_require__) {

	const Asteroid = __webpack_require__(3);
	const Bullet = __webpack_require__(7);
	const Ship = __webpack_require__(6);
	const Util = __webpack_require__(5);

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


/***/ },
/* 3 */
/***/ function(module, exports, __webpack_require__) {

	const MovingObject = __webpack_require__(4);
	const Ship = __webpack_require__(6);
	const Bullet = __webpack_require__(7);
	const Util = __webpack_require__(5);

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


/***/ },
/* 4 */
/***/ function(module, exports, __webpack_require__) {

	const Util = __webpack_require__(5);

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


/***/ },
/* 5 */
/***/ function(module, exports) {

	const Util = {
	  inherits: function(childClass, parentClass) {
	    function Surrogate () {};
	    Surrogate.prototype = parentClass.prototype;
	    childClass.prototype = new Surrogate();
	    childClass.prototype.constructor = childClass;
	  },

	  randomVec: function(length) {
	    const deg = 2 * Math.PI * Math.random();
	    return Util.scale([Math.sin(deg), Math.cos(deg)], length);
	  },

	  scale: function(vec, m) {
	    return [vec[0] * m, vec[1] * m];
	  },

	  distance: function(pos1, pos2) {
	    return Math.sqrt(
	      Math.pow((pos1[0] - pos2[0]), 2) +
	      Math.pow((pos1[1] - pos2[1]), 2));
	  },

	  norm: function(vec) {
	    return Util.distance([0,0], [vec[0], vec[1]]);
	  }
	}

	module.exports = Util;


/***/ },
/* 6 */
/***/ function(module, exports, __webpack_require__) {

	const MovingObject = __webpack_require__(4);
	const Util = __webpack_require__(5);

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


/***/ },
/* 7 */
/***/ function(module, exports, __webpack_require__) {

	const MovingObject = __webpack_require__(4);
	const Util = __webpack_require__(5);

	function Bullet() {

	};
	module.exports = Bullet;


/***/ }
/******/ ]);