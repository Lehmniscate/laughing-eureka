import { connect } from 'react-redux';
import TodoList from './todo_list';
import { allTodos, allErrors } from '../reducers/selectors.js';
import { createTodo, fetchTodos, updateTodo } from
 '../actions/todo_actions.js';
import { fetchSteps } from '../actions/step_actions';

const mapStateToProps = state => ({
  todos: allTodos(state),
  allErrors: allErrors(state)
});

const mapDispatchToProps = dispatch => ({
  createTodo: (todo) => dispatch(createTodo(todo)),
  updateTodo: (todo) => dispatch(updateTodo(todo)),
  fetchTodos: () => dispatch(fetchTodos()),
  fetchSteps: () => dispatch(fetchSteps())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(TodoList);
