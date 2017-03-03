/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.l = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// identity function for calling harmony imports with the correct context
/******/ 	__webpack_require__.i = function(value) { return value; };

/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};

/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};

/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const Router = __webpack_require__(1);
const Inbox = __webpack_require__(2);
const Sent = __webpack_require__(4);

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


/***/ }),
/* 1 */
/***/ (function(module, exports) {

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


/***/ }),
/* 2 */
/***/ (function(module, exports, __webpack_require__) {

const MessageStore = __webpack_require__(3);

const Inbox = {
  render() {
    let inboxElement = document.createElement('ul');
    inboxElement.className = "messages";
    MessageStore.getInboxMessages().forEach(message => {
      inboxElement.appendChild(this.renderMessage(message));
    });
    return inboxElement;
  },
  renderMessage(message) {
    let messageElement = document.createElement('li');
    messageElement.className = "message";
    messageElement.innerHTML = `
      <span class="from">${message.from}</span>
      <span class="subject">${message.subject}</span>
      <span class="body">${message.body}</span>
    `;
    return messageElement;
  }
};

module.exports = Inbox;


/***/ }),
/* 3 */
/***/ (function(module, exports) {

let messages = {
  sent: [{
      to: "friend@mail.com",
      subject: "Check this out",
      body: "It's so cool"
    },
    {
      to: "person@mail.com",
      subject: "zzz",
      body: "so booring"
    }
  ],

  inbox: [{
      from: "grandma@mail.com",
      subject: "Fwd: Fwd: Fwd: Check this out",
      body: "Stay at home mom discovers cure for leg cramps. Doctors hate her"
    },
    {
      from: "person@mail.com",
      subject: "Questionnaire",
      body: "Take this free quiz win $1000 dollars"
    }
  ]
};

const MessageStore = {
  getInboxMessages: function () {
    return messages.inbox;
  },

  getSentMessages: function () {
    return messages.sent;
  }
}

module.exports = MessageStore;


/***/ }),
/* 4 */
/***/ (function(module, exports, __webpack_require__) {

const MessageStore = __webpack_require__(3);

const Inbox = {
  render() {
    let inboxElement = document.createElement('ul');
    inboxElement.className = "messages";
    MessageStore.getSentMessages().forEach(message => {
      inboxElement.appendChild(this.renderMessage(message));
    });
    return inboxElement;
  },
  renderMessage(message) {
    let messageElement = document.createElement('li');
    messageElement.className = "message";
    messageElement.innerHTML = `
      <span class="to">To: ${message.to}</span>
      <span class="subject">${message.subject}</span>
      <span class="body">${message.body}</span>
    `;
    return messageElement;
  }
};

module.exports = Inbox;


/***/ })
/******/ ]);