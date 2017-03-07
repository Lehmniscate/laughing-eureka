import { connect } from 'react-redux';
import StepListItem from './step_list_item.jsx';
import { receiveStep, removeStep } from '../../actions/step_actions.js';

// const mapStateToProps = state => ({
//   todos: allTodos(state)
// });

const mapDispatchToProps = dispatch => ({
  removeStep: (step) => dispatch(removeStep(step)),
  receiveStep: (step) => dispatch(receiveStep(step))
});

export default connect(null,
  mapDispatchToProps
)(StepListItem);
