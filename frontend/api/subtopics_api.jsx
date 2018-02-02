import Reqwest from 'reqwest';

class SubtopicsApi {
  static getOrigin() {
    return (process.env.NODE_ENV === 'development' ? 'http://localhost:3000' : '')
  }

  static getSubtopics(successFunction) {
    var url = '/api/subtopics.json';

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

export default SubtopicsApi;