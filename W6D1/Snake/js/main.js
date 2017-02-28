const View = require('./snake-view.js');

$( () => {
  const rootEl = $('.snake');
  new View(rootEl);
});
