import React from 'react';
import ReactDOM from 'react-dom';

import Root from './components/root.jsx';

import { fetchAllPokemon } from './actions/pokemon_actions.js';
import configureStore from './store/store.js';
import {selectAllPokemon} from './reducers/selectors.js';

document.addEventListener('DOMContentLoaded', () => {
  const root = document.getElementById('root');
  const store = configureStore();
  window.store = store;
  ReactDOM.render(<Root store={store} />, root);
});
