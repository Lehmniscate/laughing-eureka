export const fetchTodos = () => {
  return $.ajax({ method: 'GET', url: 'api/todos' });
};

export const createTodo = (todo) => {
  return $.ajax({ method: 'POST',
                url: 'api/todos',
                data: {todo: todo},
                dataType: 'json'});
};

export const updateTodo = (todo) => {
  return $.ajax({ method: 'PATCH',
                url: `api/todos/${todo.id}`,
                data: {todo: todo},
                dataType: 'json'});
};

export const deleteTodo = (todo) => {
  return $.ajax({ method: 'DELETE',
                url: `api/todos/${todo.id}`,
                data: {todo: todo},
                dataType: 'json'});
};

export const fetchSteps = () => {
  return $.ajax({ method: 'GET', url: 'api/steps' });
};

export const createStep = (step) => {
  return $.ajax({ method: 'POST',
                url: 'api/steps',
                data: {step: step},
                dataType: 'json'});
};

export const updateStep = (step) => {
  return $.ajax({ method: 'PATCH',
                url: `api/steps/${step.id}`,
                data: {step: step},
                dataType: 'json'});
};

export const deleteStep = (step) => {
  return $.ajax({ method: 'DELETE',
                url: `api/steps/${step.id}`,
                data: {step: step},
                dataType: 'json'});
};
