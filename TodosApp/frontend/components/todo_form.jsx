import React, { Component } from 'react';

class TodoForm extends Component {
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
    this.props.receiveTodo({
      id: this.uniqueId(),
      title: this.state.title,
      body: this.state.body,
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
        <input onChange={this.onChangeTitle} value={this.state.title} placeholder="Enter a title for your Todo">

        </input>
        <input onChange={this.onChangeBody} value={this.state.body}
          placeholder="Enter description of the Todo">

        </input>
        <button onClick={this.addItem}>Add Todo</button>
      </div>
    );
  }

}

export default TodoForm;
