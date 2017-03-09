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
    if (newProps.params.pokemonId === this.props.pokemonDetail.pokemonId) {
      return;
    } else {
      this.props.fetchOnePokemon(newProps.params.pokemonId);
    }
  }

  render() {
    let content = "";
    if (this.props.pokemonDetail.name) {
      content = (
        <div>
          {this.props.pokemonDetail.name}
          <img src={this.props.pokemonDetail.image_url} />
          <div className="items">
            {this.props.pokemonDetail.items.map(item => (
              <Link key={item.id} to={`pokemon/${this.props.pokemonDetail.id}/item/${item.id}`}>
                <img key={item.id} src={item.image_url} />
              </Link>
            ))}
          </div>
        </div>
      );
    }
    return (
      <section>
        {content}
        {this.props.children}
      </section>
    );
  }
}

export default PokemonDetail;
