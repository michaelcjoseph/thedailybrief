import Reqwest from 'reqwest';

class ArticlesApi {
  static getOrigin() {
    return (process.env.NODE_ENV === 'development' ? 'http://localhost:3000' : '')
  }

  static getArticles(successFunction) {
    var url = '/api/articles.json';

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

  static updateArticleViews(article) {
    Reqwest({
      url: (this.getOrigin() + '/api/articles/' + article.id),
      method: 'post',
      data: { item: article },
      success: function() {
        console.log('Article click updated');
      }
    });
  }

  static updateArticleTopic(article, topic_id) {
    Reqwest({
      url: (this.getOrigin() + '/api/articles/' + article.id + '/' + topic_id + '/topic'),
      method: 'post',
      data: { item: article, topic_id: topic_id },
      success: function() {
        console.log('Article topic updated');
      }
    })
  }

  static updateArticleSubtopic(article, subtopic_id) {
    Reqwest({
      url: (this.getOrigin() + '/api/articles/' + article.id + '/' + subtopic_id + '/subtopic'),
      method: 'post',
      data: { item: article, subtopic_id: subtopic_id },
      success: function() {
        console.log('Article subtopic updated');
      }
    })
  }
}

export default ArticlesApi;