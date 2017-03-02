const APIUtil = require('./api_util.js');

class InfiniteTweets {
  constructor($el) {
    this.$el = $el;
    $("a.fetch-more").on("click", this.fetchTweets());
    this.maxCreatedAt = null;
    $( document ).on( "insert-tweet", this.prependTweet());
    $("a.fetch-more").trigger("click");
  }

  prependTweet() {
    return (event, tweet) => {
      this.$el.children('ul').prepend(this.tweetItem(tweet));
    };
  }

  fetchTweets(){
    return (event) => {
      console.log("Fetching More");
      let lastTweet = this.$el.find("ul li:last");
      APIUtil.feed(this.maxCreatedAt)
        .then(this.insertTweets())
        .fail((msg) => console.log(msg));
        return false;
    };

  }

  insertTweets(){
    return (tweets)=> {
      tweets.forEach( (tweet) =>{
        this.$el.children('ul').append(this.tweetItem(tweet));
      });
      if (tweets.length < 10){
        $("a.fetch-more").remove();
      }
      this.maxCreatedAt = tweets[tweets.length - 1].created_at;
    };
  }


  tweetItem (newTweet){
      let $li = $('<li>');
      $li.append(`${newTweet.content} -- `);
      let $a = $('<a>');
      $a.attr("href", `/users/${newTweet.user_id}`);
      $a.append(`${newTweet.user.username}`);
      $li.append($a);
      $li.append(` -- ${newTweet.created_at}`);
      if(newTweet.mentions.length > 0){
        let $subul = $('<ul>');
        newTweet.mentions.forEach((mention) => {
          let $mentionli = $('<li>');
          let $suba = $('<a>');
          $suba.attr("href", `/users/${mention.user_id}`);
          $suba.append(mention.user.username);
          $mentionli.append($suba);
          $subul.append($mentionli);
        });
        $li.append($subul);
      }
    return $li;
  }



}

module.exports = InfiniteTweets;
