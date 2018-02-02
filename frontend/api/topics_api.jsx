import Reqwest from 'reqwest';

class TopicsApi {
  static getOrigin() {
    return (process.env.NODE_ENV === 'development' ? 'http://localhost:3000' : '')
  }

  static getTopics(successFunction) {
    var url = '/api/topics.json';

    Reqwest({
      url: (this.getOrigin() + url),
      type: 'json',
      method: 'get',
      contentType: 'application/json',
      success: successFunction,
      error: function(error) {
        console.error(url, error['response']);
        location = '/';
      }
    });
  }
}

export default TopicsApi;