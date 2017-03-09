import React from 'react';

const TYPES = [
  "fire",
  "electric",
  "normal",
  "ghost",
  "psychic",
  "water",
  "bug",
  "dragon",
  "grass",
  "fighting",
  "ice",
  "flying",
  "poison",
  "ground",
  "rock",
  "steel"
];

class PokemonForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      name: "",
      attack: "",
      defense: "",
      image_url: "",
      move1: "",
      move2: "",
      poke_type: "fire"
    };

    this.update = this.update.bind(this);
  }

  update(property) {
    return e => this.setState({[property]: e.target.value});
  }

  handleClick(e) {
    e.preventDefault();
    this.props.createPokemon({name: this.state.name,
      attack: this.state.attack, defense: this.state.attack,
      image_url: this.state.image_url, poke_type: this.state.poke_type,
      moves: [this.state.move1, this.state.move2]});
    return false;
  }

  render() {
    let options = TYPES.map(type => (
      <option value={type}>{type}</option>
    ));
    return (
      <section className="new-pokemon-form">
        <label>Name
          <input type="text" onChange={this.update("name")}/>
        </label>
        <label>Attack
          <input type="text" onChange={this.update("attack")}/>
        </label>
        <label>Defense
          <input type="text" onChange={this.update("defense")}/>
        </label>
        <label>Image Url
          <input type="text" onChange={this.update("image_url")}/>
        </label>
        <label>Move 1
          <input type="text" onChange={this.update("move1")}/>
        </label>
        <label>Move 2
          <input type="text" onChange={this.update("move2")}/>
        </label>
        <label>Pokemon Type
          <select onChange={this.update("poke_type")}>
            {options}
          </select>
        </label>
        <button onClick={this.handleClick}>Submit</button>
      </section>
    );
  }
}

export default PokemonForm;
