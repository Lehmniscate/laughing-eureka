import React, { Component } from 'react';
import FlatButton  from 'material-ui/FlatButton';
import TextField from 'material-ui/TextField';

import FloatingActionButton from 'material-ui/FloatingActionButton';
import ContentAdd from 'material-ui/svg-icons/content/add';


const style = {
  marginRight: 20,
};


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
    console.log(this.props.todoId);
    this.props.receiveStep({
      id: this.uniqueId(),
      todoId: this.props.todoId,
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
        <TextField onChange={this.onChangeTitle} value={this.state.title} hintText="Enter a title for your Step"/>

          <FloatingActionButton onClick={this.addItem} style={style} secondary={true} mini={true}>
          <ContentAdd />
          </FloatingActionButton>
      </div>
    );
  }

}

export default StepForm;
