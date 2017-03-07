import { connect } from 'react-redux';
import TodoDetailView from './todo_detail_view.jsx';
import { allTodos } from '../reducers/selectors.js';
import { receiveTodo, removeTodo } from '../actions/todo_actions.js';
import {receiveSteps} from '../actions/step_actions.js';

// const mapStateToProps = state => ({
//   todos: allTodos(state)
// });

const mapDispatchToProps = dispatch => ({
  removeTodo: (todo) => dispatch(removeTodo(todo)),
  receiveSteps: (step) => dispatch(receiveSteps(step))
});

export default connect(null,
  mapDispatchToProps
)(TodoDetailView);
