/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;
/******/
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	const FollowToggle = __webpack_require__(1);
	const UsersSearch = __webpack_require__(3);
	const TweetCompose = __webpack_require__(4);
	const InfiniteTweets = __webpack_require__(5);
	
	$(() => $('button.follow-toggle').each( (i, el) => new FollowToggle($(el)) ));
	$(() => $('nav.users-search').each( (i, el) => new UsersSearch($(el)) ));
	$(() => $('form.tweet-compose').each( (i, el) => new TweetCompose($(el)) ));
	$(() => $('div.infinite-tweets').each( (i, el) => new InfiniteTweets($(el)) ));


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	const APIUtil = __webpack_require__(2);
	
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


/***/ },
/* 2 */
/***/ function(module, exports) {

	const APIUtil = {
	  followUser: id => {
	    return $.ajax({
	      url: `/users/${id}/follow`,
	      method: 'post',
	      dataType: 'json'
	    });
	  },
	
	  unfollowUser: id => {
	    return $.ajax({
	      url: `/users/${id}/follow`,
	      method: 'delete',
	      dataType: 'json'
	    });
	  },
	
	  searchUsers: (queryVal, success) => {
	    let data = `query=${queryVal}`;
	    return $.ajax({
	      url: '/users/search',
	      method: 'get',
	      dataType: 'json',
	      data: data
	    }).then(success).fail((msg) => console.log(msg));
	  },
	
	  createTweet: (data) => {
	    return $.ajax({
	      url: `/tweets`,
	      method: 'post',
	      dataType: 'json',
	      data: data
	    });
	  },
	
	  feed: (max_created_at) =>{
	    let data = (max_created_at ? `max_created_at=${max_created_at}` : "");
	    return $.ajax({
	      url: "/feed",
	      method: "get",
	      dataType: "json",
	      data: data
	    });
	  }
	};
	
	module.exports = APIUtil;


/***/ },
/* 3 */
/***/ function(module, exports, __webpack_require__) {

	const APIUtil = __webpack_require__(2);
	const FollowToggle = __webpack_require__(1);
	
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


/***/ },
/* 4 */
/***/ function(module, exports, __webpack_require__) {

	const APIUtil = __webpack_require__(2);
	
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


/***/ },
/* 5 */
/***/ function(module, exports, __webpack_require__) {

	const APIUtil = __webpack_require__(2);
	
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


/***/ }
/******/ ]);
//# sourceMappingURL=bundle.js.map