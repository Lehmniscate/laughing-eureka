class Router {
  constructor(node, routes) {
    this.node = node;
    this.routes = routes;
  }

  start() {
    this.render();
    document.addEventListener('hashchange', () => this.render());
  }

  render() {
    this.node.innerHTML = "";
    let newEl = document.createElement('p');
    let route = this.activeRoute();
    newEl.innerHTML = "";
    if(route) newEl.appendChild(route.render());
    this.node.appendChild(newEl);
  }

  activeRoute() {
    return this.routes[window.location.hash.slice(1)];
  }
}

module.exports = Router;
