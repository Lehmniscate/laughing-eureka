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
