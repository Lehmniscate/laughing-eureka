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
