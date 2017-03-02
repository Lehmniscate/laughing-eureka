const APIUtil = require('./api_util.js');

class FollowToggle {
  constructor($el) {
    this.user_id = $el.data("user-id");
    this.follow_state = $el.data("initial-follow-state") ? 'followed' : 'unfollowed';
    this.$el = $el;
    this.$el.click(this.handleClick());
    this.render();
  }

  render() {
    this.$el.text(this.follow_state === 'followed' ? "Unfollow" : "Follow");
  }

  handleClick (){
    return (event) => {
      this.$el.attr("disabled", true);

      event.preventDefault();

      if (this.follow_state === 'unfollowed') {
        APIUtil.followUser(this.user_id)
          .then(this.toggle())
          .fail((messg) => console.log(messg));
      }else {
        APIUtil.unfollowUser(this.user_id)
          .then(this.toggle())
          .fail((messg) => console.log(messg));
      }
    };
  }

  toggle () {
    return () => {
      this.follow_state = (this.follow_state === 'followed' ? "unfollowed" : "followed");
      this.$el.attr("disabled", false);
      this.render();
    };
  }
}

module.exports = FollowToggle;
