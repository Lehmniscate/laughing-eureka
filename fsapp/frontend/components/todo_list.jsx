import React from 'react';
import TodoListItem from './todo_list_item.jsx';
import TodoForm from './todo_form.jsx';
import AppBar from 'material-ui/AppBar';

class TodoList extends React.Component {
  componentDidMount(){
    this.props.fetchTodos();
    this.props.fetchSteps();
  }

  render() {
    let {todos, createTodo, updateTodo, allErrors} = this.props;
    return (
      <div className="todo-list-container">
        <AppBar
          title="TodoList"
        />
        <ul className="todo-list">
          {todos.map((todo, idx) => (
            <TodoListItem
            todo={todo}
            updateTodo={updateTodo}
            key={idx} /> ))}
        </ul>
        <TodoForm createTodo={createTodo} allErrors={allErrors}/>
      </div>
    );
  }

}

export default TodoList;
