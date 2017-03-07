import React from 'react';
import TodoListItem from './todo_list_item.jsx';
import TodoForm from './todo_form.jsx';

const TodoList = ( {todos, receiveTodo, removeTodo} ) => (
  <div>
    <ul>
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
