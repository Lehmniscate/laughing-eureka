import React from 'react';
import TodoListItem from './todo_list_item.jsx';
import TodoForm from './todo_form.jsx';
import AppBar from 'material-ui/AppBar';

const TodoList = ( {todos, receiveTodo, removeTodo} ) => (
  <div className="todo-list-container">
    <AppBar
      title="TodoList"
    />
    <ul className="todo-list">
      {todos.map((todo, idx) => (
        <TodoListItem
        todo={todo}
        removeTodo={removeTodo}
        receiveTodo={receiveTodo}
        key={idx} /> ))}
    </ul>
    <TodoForm receiveTodo={receiveTodo}/>
  </div>

);

export default TodoList;
