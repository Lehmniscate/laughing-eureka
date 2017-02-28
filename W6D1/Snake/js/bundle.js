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

	const View = __webpack_require__(1);

	$( () => {
	  const rootEl = $('.snake');
	  new View(rootEl);
	});


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	const Board = __webpack_require__(3);

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


/***/ },
/* 2 */
/***/ function(module, exports) {

	class Snake {
	  constructor(pos) {
	    this.direction = "N";
	    this.segments = [pos];
	  }

	  grow() {
	    this.segments.unshift([this.segments[0][0], this.segments[0][1]]);
	    switch (this.direction) {
	      case "N":
	        this.segments[0][0]--;
	        break;
	      case "S":
	        this.segments[0][0]++;
	        break;
	      case "E":
	        this.segments[0][1]++;
	        break;
	      default:
	        this.segments[0][1]--;
	    }
	    // this.segments.unshift(newPos);
	  }

	  move() {
	    this.grow();
	    this.segments.pop();
	  }

	  turn(direction) {
	    this.direction = direction;
	  }
	}

	module.exports = Snake;


/***/ },
/* 3 */
/***/ function(module, exports, __webpack_require__) {

	const Snake = __webpack_require__(2);

	class Board {
	  constructor(dimension = 30) {
	    this.dimension = dimension;
	    this.snake = new Snake([15, 15]);
	    this.growing = 0;
	    this.apple = this.generateApple();
	    this.gameOver = false;
	  }

	  generateApple() {
	    let spot = [Math.floor(Math.random() * this.dimension),
	                Math.floor(Math.random() * this.dimension)];
	    if(this.snake.segments.includes(spot)) return this.generateApple();
	    return spot;
	  }

	  move() {
	    if(this.growing > 0) {
	      console.log("Growing!");
	      this.snake.grow();
	      this.growing--;
	    } else {
	      this.snake.move();
	    }

	    if(this.apple_eaten()) {
	      this.apple = this.generateApple();
	      this.growing += 2;
	    }

	    // TODO check if out of bounds or on itself
	    if (!this.inBounds(this.snake.segments[0]) || this.snakeCollision()) {
	      this.isOver(true);
	    }
	  }

	  snakeCollision() {
	    let head = this.snake.segments[0];
	    return this.snake.segments.slice(1).filter(el => el[0] === head[0] && el[1] === head[1]).length !== 0;
	  }

	  inBounds(pos) {
	    if (pos[0] >= this.dimension || pos[0] < 0) return false;
	    if (pos[1] >= this.dimension || pos[1] < 0) return false;

	    return true;
	  }

	  isOver(value) {
	    this.gameOver = value;
	  }

	  apple_eaten() {
	    let head = this.snake.segments[0];
	    return head[0] === this.apple[0] && head[1] === this.apple[1];
	  }

	  turn(direction) {
	    this.snake.turn(direction);
	  }
	}

	module.exports = Board;


/***/ }
/******/ ]);