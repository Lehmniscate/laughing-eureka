const FollowToggle = require('./follow_toggle.js');
const UsersSearch = require('./users_search.js');
const TweetCompose = require('./tweet_compose.js');
const InfiniteTweets = require('./infinite_tweets.js');

$(() => $('button.follow-toggle').each( (i, el) => new FollowToggle($(el)) ));
$(() => $('nav.users-search').each( (i, el) => new UsersSearch($(el)) ));
$(() => $('form.tweet-compose').each( (i, el) => new TweetCompose($(el)) ));
$(() => $('div.infinite-tweets').each( (i, el) => new InfiniteTweets($(el)) ));
