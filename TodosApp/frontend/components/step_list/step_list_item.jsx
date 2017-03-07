import React, { Component} from 'react';

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
   console.log(this.props.step);
    return(
      <div>
        <p>{this.props.step.title}</p>
        <button onClick={(e) => this.props.removeStep(this.props.step)}>
          Delete Step
        </button>
        <button onClick={this.done.bind(this)}>
          {this.props.step.done ? "Undo" : "Done"}
        </button>
      </div>
    );
  }
}

export default StepListItem;
