import React from 'react';

export const Tile = ({tile, update}) => {
  let tileClass = "";
  let tileText = "";
  let onclick = (e) => update(tile.pos, e);
  let onrightclick = (e) => update(tile.pos, e, true);

  if (tile.explored) {
    let bombCount = tile.adjacentBombCount();
    if (bombCount > 0)
      tileText = bombCount;
    tileClass = " revealed";
    onclick = (e) => {
      e.preventDefault();
      return false;
    };
    onrightclick = onclick;
    if (tile.bombed) {
      tileText = "*";
      tileClass = " bombed";
    }
  }
  if (tile.flagged)
    tileClass = " flagged";
  return (
    <div className={`tile${tileClass}`} onClick={(e) => update(tile.pos, e)} onContextMenu={(e) => update(tile.pos, e, true)}>
      {tileText}
    </div>
  )
}
