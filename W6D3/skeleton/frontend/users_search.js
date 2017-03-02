const APIUtil = require('./api_util.js');
const FollowToggle = require('./follow_toggle.js');

class UsersSearch {
  constructor($el) {
    this.$el = $el;
    this.input = $el.find('input');

    this.ul = $el.find('ul');
    this.input.on("input", this.handleInput());
  }

  handleInput() {
    return (event) => {
      APIUtil.searchUsers(this.input.val(), this.renderResults());
    };
  }

  renderResults() {
    return (results) => {
      this.ul.empty();
      results.forEach((user) => {
        let $li = $('<li>');

        let $a = $('<a>');
        $a.attr('href', `/users/${user.id}`);
        $a.text(user.username);

        let $button = $('<button>');
        $button.data("user-id", user.id);
        $button.data("initial-follow-state", user.followed);
        new FollowToggle($button);

        $li.append($a);
        $li.append($button);
        this.ul.append($li);
      });
    };
  }
}

module.exports= UsersSearch;
