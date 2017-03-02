const APIUtil = require('./api_util.js');

class TweetCompose {
  constructor($el) {
    this.$el = $el;
    $el.submit(this.submit());
    this.$ul = $(this.$el.data("tweets-ul"));
    this.$textarea = this.$el.find('textarea');
    this.$textarea.attr("maxlength", 140);
    this.$textarea.on("input", this.charsLeft());

    $('a.add-mentioned-user').on("click", this.addMentionedUser());
    $('div.mentioned-users').on("click", "a.remove-mentioned-user", this.removeMentionedUser());
  }

  addMentionedUser() {
    return (event) => {
      $('div.mentioned-users').append(this.$el.find('script').html());
      return false;
    };
  }

  removeMentionedUser(){
    return (event) => {
      $(event.target).parent().remove();
      return false;
    };
  }

  charsLeft() {
    return () => {
      $('.chars-left').text(`Number of characters left: ${140 - this.$textarea.val().length}`);
    };
  }

  submit (){
    return (event) => {
      event.preventDefault();
      APIUtil.createTweet(this.$el.serializeJSON())
        .then(this.handleSuccess())
        .fail((msg) => console.log(msg));
      this.$el.find(':input').attr("disabled", true);
    };
  }

  handleSuccess() {
    return (newTweet) => {
      // call something
      $( document ).trigger("insert-tweet", [newTweet]);
      this.clearInput();
    };
  }

  clearInput (){
      this.$el.find(':input').attr("disabled", false);
      this.$el.find('.mentioned-users').empty();
      this.$el.trigger("reset");
  }
}

module.exports = TweetCompose;
