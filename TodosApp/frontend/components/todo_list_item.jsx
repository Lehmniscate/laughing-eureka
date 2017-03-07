import React, { Component} from 'react';
import TodoDetailView from './todo_detail_view_container.jsx';

class TodoListItem extends Component {
  constructor(props) {
    super(props);
    this.state = {
      todo: props.todo,
      detailedView: false,
      removeTodo: props.removeTodo,
      receiveTodo: props.receiveTodo
    };
  }
  done(e) {
    e.preventDefault();
    let newState = this.state;
    newState.todo.done = !newState.todo.done;
    this.setState(newState);
    this.state.receiveTodo(newState.todo);
    return false;
  }
  detailedView(e) {
    e.preventDefault();
    this.setState({detailedView: !this.state.detailedView});
    return false;
  }

  render(){
    const detailedView = () => {
      if (this.state.detailedView) {
      return <TodoDetailView todo={this.props.todo}/>;
       } else {
         return "";
       }
     };
    return (
      <li>
        <a onClick={this.detailedView.bind(this)}>{this.props.todo.title}</a>
        {detailedView()}
        <button onClick={this.done.bind(this)}>
          {this.props.todo.done ? "Undo" : "Done"}
        </button>
      </li>
    );
  }
}

export default TodoListItem;
