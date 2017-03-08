import { connect } from 'react-redux';
import StepListItem from './step_list_item.jsx';
import { updateStep, deleteStep } from '../../actions/step_actions.js';

// const mapStateToProps = state => ({
//   todos: allTodos(state)
// });

const mapDispatchToProps = dispatch => ({
  removeStep: (step) => dispatch(deleteStep(step)),
  receiveStep: (step) => dispatch(updateStep(step))
});

export default connect(null,
  mapDispatchToProps
)(StepListItem);
