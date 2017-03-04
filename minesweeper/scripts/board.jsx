import React from 'react';

import Tile from './tile.jsx';

export default class Board extends React.Component {
  render() {
    console.log(this.props.board.grid);
    const tiles = this.props.board.grid.map((row, i) => {
      let stuff = row.map(t => <Tile update={this.props.update} tile={t} />);
      return (<div className="row" key={i}>{stuff}</div>);
    });

    return (
      <div className="board">
        {tiles}
      </div>
    )
  }
}
