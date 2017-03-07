import React, { Component} from 'react';
import StepListContainer from './step_list/step_list_container.jsx';
class TodoDetailView extends Component {


  render(){
    return (
      <div>
        <span>{this.props.todo.body}</span>
        <button onClick={(e) => this.props.removeTodo(this.props.todo)}>
          Delete Todo
        </button>
        <StepListContainer todo_id={this.props.todo.id} />
      </div>
    );
  }
}

export default TodoDetailView;
