import {
  RECEIVE_POKEMON
} from '../actions/pokemon_actions.js';

const PokemonDetailReducer = (state = {}, action) => {
  Object.freeze(state);
  switch (action.type) {
    case RECEIVE_POKEMON:
      return action.pokemonDetail;
    default:
      return state;
  }
};

export default PokemonDetailReducer;
