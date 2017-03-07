import { connect } from 'react-redux';
import StepList from './step_list.jsx';
import { stepsByTodoId } from '../../reducers/selectors.js';
import { receiveStep } from '../../actions/step_actions.js';


const mapStateToProps = (state, { todo_id }) => ({
  steps: stepsByTodoId(state, todo_id),
  todo_id
});

const mapDispatchToProps = dispatch => ({
  receiveStep: (step) => dispatch(receiveStep(step))
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(StepList);
