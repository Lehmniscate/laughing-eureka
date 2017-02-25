const GameView = require('./lib/game_view.js')

const canvasEl = document.getElementsByTagName("canvas")[0];
canvasEl.height = window.innerHeight;
canvasEl.width = window.innerWidth;
let gv = new GameView(canvasEl);
gv.start();
