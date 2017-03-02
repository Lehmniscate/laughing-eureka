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

const DOMNodeCollection = __webpack_require__(1);

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


/***/ }),
/* 1 */
/***/ (function(module, exports) {

class DOMNodeCollection {
  constructor(htmlElements) {
    this.htmlElements = htmlElements;
  }

  html(string = null) {
    if(string === null) {
      return this.htmlElements[0].innerHTML;
    } else {
      this.htmlElements.forEach(el => el.innerHTML = string);
      return this;
    }
  }

  empty() {
    this.htmlElements.forEach(el => el.innerHTML = "");
    return this;
  }

  append(arg) {
    let toAppend = "";
    if(arg instanceof DOMNodeCollection)
      toAppend = arg.htmlElements.outerHTML;
    else if(arg instanceof HTMLElement)
      toAppend = arg.outerHTML;
    else
      toAppend = arg;

    this.htmlElements.forEach(el => el.innerHTML += toAppend);
    return this;
  }

  attr(attribute, value = null) {
    if(value === null)
      return this.htmlElements[0].getAttribute(attribute);

    this.htmlElements.forEach(el => el.setAttribute(attribute, value));

    return this;
  }

  addClass(className) {
    this.htmlElements.forEach(el => el.className += ` ${className}`);
    return this;
  }

  removeClass(className) {
    this.htmlElements.forEach(el => el.classList.remove(className));
    return this;
  }

  children() {
    let childrenArray = [];
    this.htmlElements.forEach(el => {
      for(var child of el.children) {
        childrenArray.push(child);
      }
    });
    return new DOMNodeCollection(childrenArray);
  }

  parent() {
    let parentArray = [];
    this.htmlElements.forEach(el => parentArray.push(el.parentNode));
    return new DOMNodeCollection(parentArray);
  }

  find(selector) {
    let results = [];
    this.htmlElements.forEach(el => {
      for(var result of el.querySelectorAll(selector)) {
        results.push(result);
      }
    });
    return new DOMNodeCollection(results);
  }

  remove() {
    this.htmlElements.forEach(el => el.remove());
    this.htmlElements = [];
    return this;
  }

  on(eventType, callBack) {
    this.htmlElements.forEach(el => {
      el.addEventListener(eventType, callBack);
      el[eventType] = callBack;
    });
    return this;
  }

  off(eventType) {
    this.htmlElements.forEach(el => {
      let callBack = el[eventType];
      el.removeEventListener(eventType, callBack);
    });
    return this;
  }
}

module.exports = DOMNodeCollection;


/***/ })
/******/ ]);