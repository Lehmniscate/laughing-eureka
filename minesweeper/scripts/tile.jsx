import React from 'react';

export default class Tile extends React.Component {
  handleClick() {
    this.props.update(this.props.tile.pos);
  }

  render() {
    const { pos } = this.props.tile;
    return (
      <div className="tile" key={pos.join(",")} onClick={this.handleClick.bind(this)}>T</div>
    )
  }
}
