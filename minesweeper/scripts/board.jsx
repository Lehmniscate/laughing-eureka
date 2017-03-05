import React from 'react';

import {Tile} from './tile.jsx';

export const Board = (props) => {
  const tiles = props.board.grid.map((row, i) => {
    let stuff = row.map(t => <Tile key={t.pos.join(",")} update={props.update} tile={t}/>);
    return (
      <div className="row" key={row + i}>{stuff}</div>
    );
  });

  return (
    <div className="board">
      {tiles}
    </div>
  )
};
