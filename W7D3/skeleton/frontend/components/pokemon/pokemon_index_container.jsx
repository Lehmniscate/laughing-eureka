import { connect } from 'react-redux';
import { selectAllPokemon } from "../../reducers/selectors.js";
import { fetchAllPokemon } from "../../actions/pokemon_actions.js";
import PokemonIndex from "./pokemon_index.jsx";

const mapStateToProps = state => ({
  pokemon: selectAllPokemon(state)
});

const mapDispatchToProps = dispatch => ({
  fetchAllPokemon: () => dispatch(fetchAllPokemon())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(PokemonIndex);
