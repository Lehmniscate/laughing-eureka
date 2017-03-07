import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store.js';
import { allTodos } from './reducers/selectors.js';
import { receiveTodos } from './actions/todo_actions.js';
import { receiveTodo } from './actions/todo_actions.js';
import Root from './components/root.jsx';



window.store = configureStore;
window.allTodos = allTodos;
window.receiveTodo = receiveTodo;
window.receiveTodos = receiveTodos;




document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(<Root store={configureStore}/>,
   document.getElementById('main'));
});
