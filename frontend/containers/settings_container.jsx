import React from 'react';
import {connect} from 'react-redux';
import UserSettingsApi from '../api/user_settings_api.jsx';
import Settings from '../components/settings.jsx';

class SettingsContainer extends React.Component {
  constructor(props) {
    super(props);

    var user_topics = [];
    if (typeof(this.props.user_topics["_tail"]) !== "undefined") {
      user_topics = this.props.user_topics["_tail"]["array"];
    };

    this.state = {
      general_email: this.props.email_status,
      books: this.props.books,
      user_topics: user_topics
    };
  }

  handleGeneralEmailToggle( status ) {
    UserSettingsApi.updateEmailStatus( this.props.user_id, status );
    
    this.setState({
      general_email: status
    });
  }

  handleBooksToggle() {
    UserSettingsApi.updateBooksStatus( this.props.user_id, !this.state["books"] );

    this.setState({
      books: !this.state["books"]
    });
  }

  handleTopicsToggle( topic_id ) {
    UserSettingsApi.updateTopicStatus(this.props.user_id, topic_id);

    var user_topics = this.state.user_topics;
    var index = this.state.user_topics.indexOf(topic_id);

    if ( index > -1 ) {
      user_topics.splice(index, 1)
    } else {
      user_topics.push( topic_id )
    }

    this.setState({
      user_topics: user_topics
    });
  }

  render() {
    return (
      <Settings 
        container_width={this.props.container_width}
        container_padding={this.props.container_padding} 
        feed_width={this.props.feed_width}
        general_email={this.state.general_email}
        handleGeneralEmailToggle={this.handleGeneralEmailToggle.bind(this)}
        books={this.state.books} 
        handleBooksToggle={this.handleBooksToggle.bind(this)}
        user_topics={this.state.user_topics}
        topics_by_id={this.props.topics_by_id}
        topics_by_name={this.props.topics_by_name} 
        handleTopicsToggle={this.handleTopicsToggle.bind(this)} />
    )
  }
}

function mapStateToProps(state, ownProps) {
  return {
    user_id: state.auth.getIn(['user', 'attributes', 'id']) || 'none',
    email_status: state.auth.getIn(['user', 'attributes', 'email_status']) || 'none',
    books: state.auth.getIn(['user', 'attributes', 'books']) || false,
    user_topics: state.auth.getIn(['user', 'attributes', 'topics']) || [],
    container_width: state.window_data.container_width,
    container_padding: state.window_data.container_padding,
    feed_width: state.window_data.feed_width,
    topics_by_id: state.topics.all_by_id,
    topics_by_name: state.topics.all_by_topic,
  }
}

export default connect(mapStateToProps)(SettingsContainer); 