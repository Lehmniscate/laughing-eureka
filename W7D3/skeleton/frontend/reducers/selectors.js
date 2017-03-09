import values from 'lodash/values';

export const selectAllPokemon = state => values(state.pokemon);

export const selectPokemonItem = (state, itemId) => {
  if(!state.pokemonDetail.items) return {};
  let result = state.pokemonDetail
                .items.find(item => item.id === parseInt(itemId));
  return result;
};
