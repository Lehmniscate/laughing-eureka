import React from 'react';

import * as Minesweeper from './minesweeper.js'
import {Board} from './board.jsx'

export default class Game extends React.Component {
  constructor() {
    super();
    this.state = {
      board: new Minesweeper.Board(20, 40)
    }
    this.updateGame = this.updateGame.bind(this);
    this.newGame = this.newGame.bind(this);
  }

  newGame(e) {
    e.preventDefault();
    this.setState({
      board: new Minesweeper.Board(20, 40)
    })
    return false;
  }

  updateGame(pos, e, flag = false) {
    e.preventDefault();
    if (flag)
      this.state.board.grid[pos[0]][pos[1]].toggleFlag();
    else
      this.state.board.grid[pos[0]][pos[1]].explore();
    this.setState({board: this.state.board});
    return false;
  }

  render() {
    return (
      <div className="game">
        <Board board={this.state.board} update={this.updateGame}/>
        <button class="btn" onClick={this.newGame}>New Game</button>
      </div>
    );
  }
}
