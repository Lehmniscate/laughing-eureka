import React, { Component} from 'react';
import FlatButton  from 'material-ui/FlatButton';
import TextField from 'material-ui/TextField';

class StepListItem extends Component {
  constructor(props) {
    super(props);
    this.state = {
      step: props.step
    };
  }

  done(e) {
    e.preventDefault();
    let newState = this.state;
    newState.step.done = !newState.step.done;
    this.setState(newState);
    this.state.receiveStep(newState.step);
    return false;
  }


 render() {
    return(
      <div>
        <p>{this.props.step.title}</p>
        <FlatButton onClick={(e) => this.props.removeStep(this.props.step)}
          label="Delete Step"
          secondary={true}/>

        <FlatButton onClick={this.done.bind(this)}
          label={this.props.step.done ? "Undo" : "Done"}
          secondary={true} />
      </div>
    );
  }
}

export default StepListItem;
