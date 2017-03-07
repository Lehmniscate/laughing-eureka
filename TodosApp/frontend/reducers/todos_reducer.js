import { RECEIVE_TODOS,
  RECEIVE_TODO,
  REMOVE_TODO } from '../actions/todo_actions';
import merge from 'lodash/merge';

const initialState = {
  1: {
    id: 1,
    title: "wash car",
    body: "with soap",
    done: false
  },
  2: {
    id: 2,
    title: "wash dog",
    body: "with shampoo",
    done: true
  }

};


const todosReducer = (state = initialState, action) => {
  switch(action.type) {
    case RECEIVE_TODOS:
      let newState = {};
      action.payload.forEach( (todo) => {
        newState[todo.id] = todo;
      });
      return newState;
    case RECEIVE_TODO:
      newState = merge({}, state);
      newState[action.payload.id] = action.payload;
      return newState;
    case REMOVE_TODO:
      newState = {};
      Object.keys(state).forEach(key => {
        if(state[key] !== action.payload) {
          newState[key] = merge({}, state[key]);
        }
      });
      return newState;
    default:
      return state;
  }
};

export default todosReducer;
