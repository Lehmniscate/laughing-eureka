import React from "react";
import PokemonIndexItem from "./pokemon_index_item.jsx";

class PokemonIndex extends React.Component {
  constructor(props) {
    super(props);
  }

  componentWillMount() {
    this.props.fetchAllPokemon()
      .then(pokemon => {
        console.log(this.props.router.location.pathname);
        if(this.props.router.location.pathname === "/"){
          let keys = Object.keys(pokemon);
          let id = keys[Math.floor(Math.random() * keys.length)];
          this.props.router.push(`pokemon/${id}`);
        }
      });
  }

  render() {
    const pokemonItems = this.props.pokemon
      .map(p => <PokemonIndexItem key={p.id} pokemon={p} />);
    return (
      <section className="pokedex">
        <ul className="all-pokemon">
          {pokemonItems}
        </ul>

        {this.props.children}
      </section>
    );
  }
}

export default PokemonIndex;
