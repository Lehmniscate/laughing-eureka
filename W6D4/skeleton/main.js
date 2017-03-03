const Router = require('./router');
const Inbox = require('./inbox');
const Sent = require('./sent');

let routes = {
  inbox: Inbox,
  sent: Sent
};

document.addEventListener("DOMContentLoaded", () => {
  for (var li of document.querySelectorAll('.sidebar-nav li')) {
    li.addEventListener('click', (event) => {
      window.location.hash = event.target.innerText.toLowerCase();
      new Router(document.querySelector('.content'), routes).start();
    });
  }
  window.location.hash = 'inbox';
  new Router(document.querySelector('.content'), routes).start();

});
