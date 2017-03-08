import { createStore, applyMiddleware } from 'redux';
import rootReducer from '../reducers/root_reducer';
import thunk from '../middleware/thunk.js';

const configureStore = () => {
  let defaultstore = localStorage.store ?
                JSON.parse(localStorage.store) : {};
  let store = createStore(rootReducer,
                      defaultstore,
                      applyMiddleware(thunk));
  store.subscribe(() => {
    localStorage.setItem('store', JSON.stringify(store.getState()));
  });
  return store;
};

export default configureStore();
