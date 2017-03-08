import * as APIUtil from '../util/todo_api_util.js';
import {receiveErrors, clearErrors} from './error_actions.js';

export const RECEIVE_TODOS = "RECEIVE_TODOS";
export const RECEIVE_TODO = "RECEIVE_TODO";
export const REMOVE_TODO = "REMOVE_TODO";

export const receiveTodos = (todos) => {
  return {
    type: RECEIVE_TODOS,
    payload: todos
  };
};

export const receiveTodo = (todo) => {
  return {
    type: RECEIVE_TODO,
    payload: todo
  };
};

export const removeTodo = (todo) => {
  return {
    type: REMOVE_TODO,
    payload: todo
  };
};

export const fetchTodos = () => {
  return (dispatch) => {
    return APIUtil.fetchTodos()
      .then(r => dispatch(receiveTodos(r)));
  };
};

export const createTodo = (todo) => {
  return (dispatch) => {
    return APIUtil.createTodo(todo)
      .then(t => dispatch(receiveTodo(t)))
      .then(() => dispatch(clearErrors()))
      .fail(err => dispatch(receiveErrors(err.responseJSON)));
  };
};

export const updateTodo = (todo) => {
  return (dispatch) => {
    return APIUtil.updateTodo(todo)
      .then(t => dispatch(receiveTodo(t)))
      .then(() => dispatch(clearErrors()))
      .fail(err => dispatch(receiveErrors(err.responseJSON)));
  };
};

export const deleteTodo = (todo) => {
  return (dispatch) => {
    return APIUtil.deleteTodo(todo)
      .then(() => dispatch(removeTodo(todo)))
      .then(() => dispatch(clearErrors()))
      .fail(err => dispatch(receiveErrors(err.responseJSON)));
  };
};
