import merge from 'lodash/merge';
import {
  RECEIVE_ALL_POKEMON,
  ADD_POKEMON
} from '../actions/pokemon_actions.js';

const PokemonReducer = (state = [], action) => {
  Object.freeze(state);
  switch (action.type) {
    case RECEIVE_ALL_POKEMON:
      return action.pokemon;
    case ADD_POKEMON:
      let newPokemon = {};
      newPokemon[action.pokemon.id] = action.pokemon;
      const newState = merge(newPokemon, state);
      return newState;
    default:
      return state;
  }
};

export default PokemonReducer;
