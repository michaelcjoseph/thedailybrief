import Reqwest from 'reqwest';

class UserSettingsApi {
  static getOrigin() {
    return (process.env.NODE_ENV === 'development' ? 'http://localhost:3000' : '')
  }

  static updateEmailStatus(user_id, email_status) {
    Reqwest({
      url: (this.getOrigin() + '/api/users/' + user_id + '/' + email_status),
      method: 'post',
      data: { id: user_id, email_status: email_status },
      success: function() {
        console.log('User email status updated');
      }
    });
  }

  static updateBooksStatus(user_id, status) {
    Reqwest({
      url: (this.getOrigin() + '/api/users/' + user_id + '/books/' + status),
      method: 'post',
      data: { id: user_id, books: status },
      success: function() {
        console.log('User books status updated');
      }
    });
  }

  static updateTopicStatus(user_id, topic_id) {
    Reqwest({
      url: (this.getOrigin() + '/api/users/' + user_id + '/topics/' + topic_id),
      method: 'post',
      data: { id: user_id, [topic_id]: status },
      success: function() {
        console.log('User status updated for ' + topic_id);
      }
    });
  }
}

export default UserSettingsApi;