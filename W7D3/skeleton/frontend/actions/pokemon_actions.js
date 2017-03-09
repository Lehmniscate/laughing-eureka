import * as APIUtil from "../util/api_util.js";
export const RECEIVE_ALL_POKEMON = "RECEIVE_ALL_POKEMON";
export const RECEIVE_POKEMON = "RECEIVE_POKEMON";
export const ADD_POKEMON = "ADD_POKEMON";

export const receiveAllPokemon = pokemon => ({
  type: RECEIVE_ALL_POKEMON,
  pokemon
});

export const receivePokemon = pokemonDetail => ({
  type: RECEIVE_POKEMON,
  pokemonDetail
});

export const addPokemon = pokemon => ({
  type: ADD_POKEMON,
  pokemon
});

export const fetchAllPokemon = () => {
  return dispatch => {
    return APIUtil.fetchAllPokemon()
      .then(pokemon => dispatch(receiveAllPokemon(pokemon)));
  };
};

export const fetchOnePokemon = (pokemonId) => {
  return dispatch => {
    return APIUtil.fetchOnePokemon(pokemonId)
      .then(pokemon => dispatch(receivePokemon(pokemon)));
  };
};

export const createPokemon = (pokemon) => {
  return dispatch => {
    return APIUtil.createPokemon(pokemon)
      .then(() => dispatch(addPokemon(pokemon)));
  };
};
