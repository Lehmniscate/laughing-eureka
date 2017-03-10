import { combineReducers } from 'redux';

import PokemonReducer from './pokemon_reducer';
import ErrorsReducer from './errors_reducer';
import PokemonDetailReducer from './pokemon_detail_reducer';

const rootReducer = combineReducers({
  pokemon: PokemonReducer,
  pokemonDetail: PokemonDetailReducer,
  errors: ErrorsReducer
});

export default rootReducer;
