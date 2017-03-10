import React from "react";
import { Link } from 'react-router';

class PokemonDetail extends React.Component {
  constructor(props) {
    super(props);
  }

  componentWillMount() {
    this.props.fetchOnePokemon(this.props.params.pokemonId);
  }

  componentWillReceiveProps(newProps) {
    if (newProps.params.pokemonId === this.props.params.pokemonId) {
      return;
    } else {
      this.props.fetchOnePokemon(newProps.params.pokemonId);
    }
  }

  render() {
    let pokemon = this.props.pokemonDetail;
    if (pokemon.name) {
      let type = pokemon.poke_type;
      let capType = type[0].toUpperCase().concat(type.slice(1));
      let moves = pokemon.moves
        .map(move => move.split(" ")
          .map(word => word[0].toUpperCase().concat(word.slice(1))).join(" "));
      let typeClass = `pokemon-detail ${type}`;
      return (
        <section className={typeClass}>
          <div>
            <img src={pokemon.image_url} />
          </div>
          <div>
            <h1>{pokemon.name}</h1>
            <div className="pokemon-information">
              <div className="pokemon-stats">
                <div>
                  <span className="pokemon-stats-type">Type: </span>
                  <span className="pokemon-stats-attack">Attack: </span>
                  <span>{pokemon.attack}</span>
                </div>
                <div>
                  <span className="pokemon-stats-type">{capType}</span>
                  <span className="pokemon-stats-attack">Defense: </span>
                  <span>{pokemon.defense}</span>
                </div>
              </div>

              <div className="pokemon-moves">
                <div>Moves:</div>
                {moves.map(move => <div>{move}</div>)}
              </div>
            </div>
            <div className="items">
              {pokemon.items.map(item => (
                <Link key={item.id}
                  to={`pokemon/${pokemon.id}/item/${item.id}`}>
                  <img key={item.id} src={item.image_url} />
                </Link>))}
              </div>

            {this.props.children}
          </div>
        </section>
      );
    } else {
      return (<section></section>);
    }
  }
}

export default PokemonDetail;
