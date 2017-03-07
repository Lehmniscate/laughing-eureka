import React, { Component} from 'react';
import StepListItemContainer from './step_list_item_container.jsx';
import StepForm from './step_form.jsx';

const StepList = ({steps, removeStep, receiveStep, todo_id}) => {
    return(
      <div>
        <ul>
          {steps.map((step, idx) => (
            <StepListItemContainer
            step={step}
            key={idx} /> ))}
        </ul>
        <StepForm todo_id={todo_id} receiveStep={receiveStep} />
      </div>
    );
};

export default StepList;
