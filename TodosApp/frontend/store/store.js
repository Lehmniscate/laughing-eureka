import { createStore } from 'redux';
import rootReducer from '../reducers/root_reducer';

const configureStore = () => {
  let store = {};
  if(localStorage.store) {
    store = createStore(
      rootReducer,
      JSON.parse(localStorage.store));
  }else {
    store = createStore(rootReducer);
  }
  store.subscribe(() => {
    localStorage.setItem('store', JSON.stringify(store.getState()));
  });
  return store;
};

export default configureStore();
