export const allTodos = ( {todos} ) => {
  return Object.keys(todos).map( id => todos[id]);
};

export const stepsByTodoId = ( {steps}, todoId ) => {
  console.log(todoId);
  return Object.keys(steps)
    .filter( id => steps[id].todoId === todoId)
    .map(id => steps[id]);
};
