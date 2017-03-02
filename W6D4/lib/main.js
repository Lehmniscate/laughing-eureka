const DOMNodeCollection = require('./dom_node_collection.js');

window.$l = function(selector) {
  if(typeof selector === 'string') {
    let elementArray = [];
    for(var el of document.querySelectorAll(selector)) {
      elementArray.push(el);
    }
    return new DOMNodeCollection(elementArray);
  } else if (selector instanceof HTMLElement) {
    return new DOMNodeCollection([selector]);
  } else if (selector instanceof Function) {
    if(document.readyState === "complete") {
      selector();
      return true;
    } else {
      document.addEventListener("DOMContentLoaded", () => {
        document.removeEventListener("DOMContentLoaded", arguments.callee);
        selector();
      });
    }
  }
}

window.$l.extend = function(...args) {
  let result = {};
  args.forEach(arg => {
    Object.keys(arg).forEach(key => result[key] = arg[key]);
  });
  return result;
}

window.$l.ajax = function(request) {
  let defaults = {
    success: () => true,
    error: (msg) => console.log(msg),
    url: window.location.href,
    method: 'GET',
    data: '',
    contentType: 'JSON'
  };
  let options = $l.extend(defaults, request);

  const xhr = new XMLHttpRequest();

  xhr.open(options.method, options.url);

  xhr.onload = () => {
    if(xhr.status === 200)
      options.success(xhr.response);
    else
      options.error(xhr.response);
  }

  xhr.send(options.data);
}
