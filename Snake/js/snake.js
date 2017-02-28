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
