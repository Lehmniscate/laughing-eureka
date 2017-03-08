import * as APIUtil from '../util/todo_api_util.js';
import {receiveErrors, clearErrors} from './error_actions.js';

export const RECEIVE_STEPS = "RECEIVE_STEPS";
export const RECEIVE_STEP = "RECEIVE_STEP";
export const REMOVE_STEP = "REMOVE_STEP";

export const receiveSteps = (steps) => {
  return {
    type: RECEIVE_STEPS,
    payload: steps
  };
};

export const receiveStep = (step) => {
  return {
    type: RECEIVE_STEP,
    payload: step
  };
};

export const removeStep = (step) => {
  return {
    type: REMOVE_STEP,
    payload: step
  };
};

export const fetchSteps = () => {
  return (dispatch) => {
    return APIUtil.fetchSteps()
      .then(r => dispatch(receiveSteps(r)));
  };
};

export const createStep = (step) => {
  return (dispatch) => {
    return APIUtil.createStep(step)
      .then(t => dispatch(receiveStep(t)))
      .then(() => dispatch(clearErrors()))
      .fail(err => dispatch(receiveErrors(err.responseJSON)));
  };
};

export const updateStep = (step) => {
  return (dispatch) => {
    return APIUtil.updateStep(step)
      .then(t => dispatch(receiveStep(t)))
      .then(() => dispatch(clearErrors()))
      .fail(err => dispatch(receiveErrors(err.responseJSON)));
  };
};

export const deleteStep = (step) => {
  return (dispatch) => {
    return APIUtil.deleteStep(step)
      .then(() => dispatch(removeStep(step)))
      .then(() => dispatch(clearErrors()))
      .fail(err => dispatch(receiveErrors(err.responseJSON)));
  };
};
