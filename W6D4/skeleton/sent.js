const MessageStore = require('./message_store');

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
