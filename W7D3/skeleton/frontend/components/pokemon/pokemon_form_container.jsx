import { connect } from 'react-redux';
import { createPokemon } from "../../actions/pokemon_actions.js";
import PokemonForm from "./pokemon_form.jsx";

const mapStateToProps = state => ({
  errors: state.errors
});

const mapDispatchToProps = dispatch => ({
  createPokemon: (pokemon) => dispatch(createPokemon(pokemon))
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(PokemonForm);
