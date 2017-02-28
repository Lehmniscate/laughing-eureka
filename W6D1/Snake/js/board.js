const Snake = require("./snake.js");

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
