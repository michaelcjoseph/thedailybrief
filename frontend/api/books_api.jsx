import Reqwest from 'reqwest';

class BooksApi {
  static getOrigin() {
    return (process.env.NODE_ENV === 'development' ? 'http://localhost:3000' : '')
  }

  static getBooks(successFunction) {
    var url = '/api/books.json';

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

  static updateBookViews(book, button) {
    Reqwest({
      url: (this.getOrigin() + '/api/books/' + book.id + '/' + button),
      method: 'post',
      data: { item: book },
      success: function() {
        console.log('Book click updated for ' + button);
      }
    });
  }

  static updateBookTopic(book, topic_id) {
    Reqwest({
      url: (this.getOrigin() + '/api/books/' + book.id + '/' + topic_id + '/topic'),
      method: 'post',
      data: { item: book, topic_id: topic_id },
      success: function() {
        console.log('Book topic updated');
      }
    })
  }

  static updateBookSubtopic(book, subtopic_id) {
    Reqwest({
      url: (this.getOrigin() + '/api/books/' + book.id + '/' + subtopic_id + '/subtopic'),
      method: 'post',
      data: { item: book, subtopic_id: subtopic_id },
      success: function() {
        console.log('Book subtopic updated');
      }
    })
  }
}

export default BooksApi;