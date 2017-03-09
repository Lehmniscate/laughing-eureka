import React from "react";
import PokemonIndexItem from "./pokemon_index_item.jsx";

class PokemonIndex extends React.Component {
  constructor(props) {
    super(props);
  }

  componentWillMount() {
    this.props.fetchAllPokemon();
  }

  render() {
    const pokemonItems = this.props.pokemon
      .map(p => <PokemonIndexItem key={p.id} pokemon={p} />);
    return (
      <section>
        {this.props.children}
        <ul className="all-pokemon">
          {pokemonItems}
        </ul>
      </section>
    );
  }
}

export default PokemonIndex;
