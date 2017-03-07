import { connect } from 'react-redux';
import StepList from './step_list.jsx';
import { stepsByTodoId } from '../../reducers/selectors.js';
import { receiveStep } from '../../actions/step_actions.js';


const mapStateToProps = (state, { todoId }) => ({
  steps: stepsByTodoId(state, todoId),
  todoId
});

const mapDispatchToProps = dispatch => ({
  receiveStep: (step) => dispatch(receiveStep(step))
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(StepList);
