import { CLEAR_ERRORS, RECEIVE_ERRORS } from '../actions/error_actions';

const InitialState = [];

const errorReducer = (state = InitialState, action) => {
  switch (action.type) {
    case RECEIVE_ERRORS:
      return action.errors;
    case CLEAR_ERRORS:
      return InitialState;
    default:
      return state;
  }
};

export default errorReducer;
