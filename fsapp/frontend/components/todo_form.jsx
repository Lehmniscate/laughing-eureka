import React, { Component } from 'react';

import FlatButton  from 'material-ui/FlatButton';
import TextField from 'material-ui/TextField';
import FloatingActionButton from 'material-ui/FloatingActionButton';
import ContentAdd from 'material-ui/svg-icons/content/add';


const style = {
  marginRight: 20,
};

class TodoForm extends Component {
  constructor(props){
    super(props);
    this.state = { title: "", body: "", newTag: "", tag_names: []};
    this.onChangeTitle = this.onChangeTitle.bind(this);
    this.onChangeBody = this.onChangeBody.bind(this);
    this.addItem = this.addItem.bind(this);
    this.onChangeTag = this.onChangeTag.bind(this);
    this.addTag = this.addTag.bind(this);

  }

  onChangeTitle(e) {
    this.setState({title: e.target.value});
  }

  onChangeBody(e) {
    this.setState({body: e.target.value});
  }

  addItem(e) {
    e.preventDefault();
    this.props.createTodo({
      id: this.uniqueId(),
      title: this.state.title,
      body: this.state.body,
      tag_names: this.state.tag_names,
      done: false
    }).then(() => this.setState({title: "", body: ""}))
      .fail(() => this.setState(this.state));
    return false;
  }

  uniqueId() {
    return new Date().getTime();
  }

  onChangeTag(e){
    this.setState({newTag: e.target.value});
  }

  addTag(e){
    e.preventDefault();
    this.state.tag_names.push(this.state.newTag);
    this.setState({tag_names: this.state.tag_names});

    return false;
  }

  render(){
    let errorText = "";
    if (this.props.allErrors) {
      errorText = <ul>
                    {this.props.allErrors.map(e => <li key = {e}>{e}</li>)}
                  </ul>;
    }
    let tags = this.state.tag_names.map((tag) => {
      return <li key={tag}>{tag}</li>;
    });


    return (
      <div>
        {errorText}
        <TextField onChange={this.onChangeTag}
          value={this.state.newTag}
          hintText="Add Tag"/>
        <FloatingActionButton type="button" onClick={this.addTag}
          mini={true}><ContentAdd/></FloatingActionButton>
        <TextField onChange={this.onChangeTitle} value={this.state.title}
        hintText="Enter a title for your Todo"/>
        <TextField onChange={this.onChangeBody} value={this.state.body}
        hintText="Enter description of the Todo"/>
      <ul>{tags}</ul>

      <FloatingActionButton onClick={this.addItem} style={style}>
      <ContentAdd />
      </FloatingActionButton>
      </div>
    );
  }

}

export default TodoForm;
