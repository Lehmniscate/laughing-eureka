import React, { Component } from 'react';

class StepForm extends Component {
  constructor(props){
    super(props);
    this.state = { title: "", body: ""};
    this.onChangeTitle = this.onChangeTitle.bind(this);
    this.onChangeBody = this.onChangeBody.bind(this);
    this.addItem = this.addItem.bind(this);
  }

  onChangeTitle(e) {
    this.setState({title: e.target.value});
  }

  onChangeBody(e) {
    this.setState({body: e.target.value});
  }

  addItem(e) {
    e.preventDefault();
    this.props.receiveStep({
      id: this.uniqueId(),
      title: this.state.title,
      done: false
    });
    this.setState({title: "", body: ""});
    return false;

  }

  uniqueId() {
    return new Date().getTime();
  }

  render(){
    return (
      <div>
        <input onChange={this.onChangeTitle} value={this.state.title} placeholder="Enter a title for your Step">

        </input>

        <button onClick={this.addItem}>Add Step</button>
      </div>
    );
  }

}

export default StepForm;
