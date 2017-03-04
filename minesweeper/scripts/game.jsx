import React from 'react';

import * as Minesweeper from './minesweeper.js'
import Board from './board.jsx'

export default class Game extends React.Component {
  constructor() {
    super();
    this.state = {
      board: new Minesweeper.Board(20, 10)
    }
    this.updateGame = this.updateGame.bind(this);
  }

  updateGame() {

  }

  render() {
    return (
      <Board board={this.state.board} update={this.updateGame}/>
    )
  }
}
