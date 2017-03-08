import React, { Component} from 'react';
import TodoDetailView from './todo_detail_view_container.jsx';

import FlatButton  from 'material-ui/FlatButton';

class TodoListItem extends Component {
  constructor(props) {
    super(props);
    this.state = {
      todo: props.todo,
      detailedView: false,
      updateTodo: props.updateTodo
    };
  }
  done(e) {
    e.preventDefault();
    let newState = this.state;
    newState.todo.done = !newState.todo.done;
    this.setState(newState);
    this.state.updateTodo(newState.todo);
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
      <li className="todo-list-item">
        <div className="todo-list-title">
          <a onClick={this.detailedView.bind(this)}>
            {this.props.todo.title}
          </a>
          <FlatButton
            label={this.props.todo.done ? "Undo" : "Done"}
            onClick={this.done.bind(this)} primary={true}/>
        </div>
        <div className="todo-list-details">
          {detailedView()}
        </div>
      </li>
    );
  }
}

export default TodoListItem;
