import merge from 'lodash/merge';
import {
  RECEIVE_ERRORS
} from '../actions/pokemon_actions.js';

const ErrorsReducer = (state = [], action) => {
  Object.freeze(state);
  switch (action.type) {
    case RECEIVE_ERRORS:
      return action.errors;
    default:
      return state;
  }
};

export default ErrorsReducer;
