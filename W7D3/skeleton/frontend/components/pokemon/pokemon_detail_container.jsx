import { connect } from 'react-redux';
import { selectAllPokemon } from "../../reducers/selectors.js";
import { fetchOnePokemon } from "../../actions/pokemon_actions.js";
import PokemonDetail from "./pokemon_detail.jsx";

const mapStateToProps = state => ({
  pokemonDetail: state.pokemonDetail
});

const mapDispatchToProps = dispatch => ({
  fetchOnePokemon: (id) => dispatch(fetchOnePokemon(id))
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(PokemonDetail);
