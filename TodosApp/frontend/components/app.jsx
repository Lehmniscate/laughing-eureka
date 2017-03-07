import React from 'react';
import TodoListContainer from './todo_list_container.jsx';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';

const App = () => {
  return (
    <MuiThemeProvider>
      <TodoListContainer />
    </MuiThemeProvider>
  );
};

export default App;
