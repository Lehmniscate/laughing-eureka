import React from 'react';

import * as Minesweeper from './minesweeper.js'
import {Board} from './board.jsx'

export default class Game extends React.Component {
  constructor() {
    super();
    this.state = {
      board: new Minesweeper.Board(20, 40),
      time: 0,
      boardSize: 20,
      numBombs: 40
    }
    this.updateGame = this.updateGame.bind(this);
    this.newGame = this.newGame.bind(this);
    this.chSize = this.chSize.bind(this);
    this.chNBombs = this.chNBombs.bind(this);
  }

  newGame(e) {
    e.preventDefault();
    this.resetGame();
    return false;
  }

  updateGame(pos, e, flag = false) {
    e.preventDefault();
    let {board} = this.state;

    if (flag)
      board.grid[pos[0]][pos[1]].toggleFlag();
    else
      board.grid[pos[0]][pos[1]].explore();

    this.setState({board: board});
    this.render();

    if (board.won()) {
      setTimeout(() => {
        alert("You won!");
        this.resetGame();
      }, 200);
      this.revealBoard();
    } else if (board.lost()) {
      setTimeout(() => {
        alert("You lost!");
        this.resetGame();
      }, 200);
      this.revealBoard();
    }
    return false;
  }

  revealBoard() {
    this.state.board.grid.forEach(row => {
      row.forEach(tile => tile.explored = true);
    });
    this.setState({board: this.state.board});
  }

  resetGame() {
    this.setState({
      board: new Minesweeper.Board(this.state.boardSize, this.state.numBombs)
    })
  }

  chSize(e) {
    this.setState({boardSize: e.target.value});
  }

  chNBombs(e) {
    this.setState({numBombs: e.target.value});
  }

  render() {
    return (
      <div className="game">
        <Board board={this.state.board} update={this.updateGame}/>
        <div className="settings">
          <div className="input">
            <div className="inputLabel">Board Size</div>
            <input className="inputText" onChange={this.chSize} value={this.state.boardSize}></input>
          </div>
          <div className="input">
            <div className="inputLabel">Number of Bombs</div>
            <input className="inputText" onChange={this.chNBombs} value={this.state.numBombs}></input>
          </div>
          <button className="btn" onClick={this.newGame}>New Game</button>
        </div>
      </div>
    );
  }
}
