import Reqwest from 'reqwest';

class PodcastsApi {
  static getOrigin() {
    return (process.env.NODE_ENV === 'development' ? 'http://localhost:3000' : '')
  }

  static getPodcasts(successFunction) {
    var url = '/api/podcasts.json';

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

  static updatePodcastViews(podcast) {
    Reqwest({
      url: (this.getOrigin() + '/api/podcasts/' + podcast.id),
      method: 'post',
      data: { item: podcast },
      success: function() {
        console.log('Podcast click updated');
      }
    });
  }

  static updatePodcastTopic(podcast, topic_id) {
    Reqwest({
      url: (this.getOrigin() + '/api/podcasts/' + podcast.id + '/' + topic_id + '/topic'),
      method: 'post',
      data: { item: podcast, topic_id: topic_id },
      success: function() {
        console.log('Podcast topic updated');
      }
    })
  }

  static updatePodcastSubtopic(podcast, subtopic_id) {
    Reqwest({
      url: (this.getOrigin() + '/api/podcasts/' + podcast.id + '/' + subtopic_id + '/subtopic'),
      method: 'post',
      data: { item: podcast, subtopic_id: subtopic_id },
      success: function() {
        console.log('Podcast subtopic updated');
      }
    })
  }
}

export default PodcastsApi;