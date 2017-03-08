import React, { Component} from 'react';
import StepListContainer from './step_list/step_list_container.jsx';

import FlatButton  from 'material-ui/FlatButton';

class TodoDetailView extends Component {

  deleteTodo(e) {
    e.preventDefault();
    this.props.removeTodo(this.props.todo);
    return false;
  }

  render(){
    return (
      <div>
        <span>{this.props.todo.body}</span>
        <FlatButton onClick={this.deleteTodo.bind(this)}
          label="Delete Todo" secondary={true}/>
        <StepListContainer todoId={this.props.todo.id} />
      </div>
    );
  }
}

export default TodoDetailView;
