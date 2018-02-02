import React from 'react';
import {connect} from 'react-redux';
import ArticlesApi from '../api/articles_api.jsx';
import PodcastsApi from '../api/podcasts_api.jsx';
import BooksApi from '../api/books_api.jsx';
import HeaderContainer from './header_container.jsx';
import BannerContainer from './banner_container.jsx';
import MainMenuContainer from './main_menu_container.jsx';
import SourcesMenu from '../components/sources_menu.jsx'
import Feed from '../components/feed.jsx';
import Footer from '../components/footer.jsx';

class Body extends React.Component {
  // Create style for main body content
  getContentBodyStyle() {
    var padding = (this.props.container_width - this.props.feed_width) / 2;

    var style = { 
      width: this.props.container_width + 'px', 
      marginLeft: this.props.container_padding + 'px',
      marginRight: this.props.container_padding + 'px',
      paddingLeft: padding + 'px',
      paddingRight: padding + 'px'
    }

    return style
  }

  handleClick(item, button=null) {
    if ( item.type == 'Article' ) {
      ArticlesApi.updateArticleViews(item);
    } else if ( item.type == 'Podcast' ) {
      PodcastsApi.updatePodcastViews(item);
    } else if ( item.type == 'Book' ) {
      BooksApi.updateBookViews(item, button);
    }
  }

  handleTopicSelect(item, topic_id) {
    if ( item.type == 'Article' ) {
      ArticlesApi.updateArticleTopic(item, topic_id);
    } else if ( item.type == 'Podcast' ) {
      PodcastsApi.updatePodcastTopic(item, topic_id);
    } else if ( item.type == 'Book' ) {
      BooksApi.updateBookTopic(item, topic_id);
    }
  }

  handleSubtopicSelect(item, subtopic_id) {
    if ( item.type == 'Article' ) {
      ArticlesApi.updateArticleSubtopic(item, subtopic_id);
    } else if ( item.type == 'Podcast' ) {
      PodcastsApi.updatePodcastSubtopic(item, subtopic_id);
    } else if ( item.type == 'Book' ) {
      BooksApi.updateBookSubtopic(item, subtopic_id);
    }
  }

  filterItemsBySource() {
    var new_items = [];

    for ( var i = 0; i < this.props.items.length; i++ ) {
      if ( this.props.items[i].header == this.props.source ) {
        new_items.push(this.props.items[i]);
      }
    }

    return new_items;
  }

  filterItemsByTopic() {
    var new_items = [];

    var topic = this.props.topic == 'Race' ? 'Race & Culture' : this.props.topic; 

    for ( var i = 0; i < this.props.items.length; i++ ) {
      if ( this.props.items[i].topic_id == this.props.topics_by_name[topic] ) {
        new_items.push(this.props.items[i]);
      }
    }

    return new_items;
  }

	render() {
    var is_admin = (this.props.current_user_email == 'michael@thedailybrief.co') ? true : false;

    var items = (
      this.props.source ? this.filterItemsBySource() : (
        this.props.topic ? this.filterItemsByTopic() : this.props.items
      )
    );

		return (
      <div>
        <HeaderContainer />
        <MainMenuContainer source={this.props.source} />
    		<div className="main-container col-xs-12">
          { this.props.type == 'Top Stories' ? <BannerContainer type={this.props.type} /> : null }
          { this.props.type == 'Latest' ? <SourcesMenu sources={this.props.sources} /> : null }
          <div className="main-content-body col-xs-12" style={this.getContentBodyStyle()}>
      			<Feed
              is_admin={is_admin}
              type={this.props.type}
              topic={this.props.topic}
              signed_in={this.props.signed_in}
              items={items}
              sources={this.props.sources}
              topics_by_id={this.props.topics_by_id}
              topics_by_name={this.props.topics_by_name}
              subtopics_by_id={this.props.subtopics_by_id}
              subtopics_by_name={this.props.subtopics_by_name}
              subtopic_to_topic={this.props.subtopic_to_topic}
              feed_width={this.props.feed_width}
              handleClick={this.handleClick.bind(this)} 
              handleTopicSelect={this.handleTopicSelect.bind(this)} 
              handleSubtopicSelect={this.handleSubtopicSelect.bind(this)} />
            <Footer />
          </div>
    		</div>
      </div>
		)
	}
}

function mapStateToProps(state, ownProps) {
  return {
    signed_in: state.auth.getIn(["user", "isSignedIn"]),
    current_user_email: state.auth.getIn(['user', 'attributes', 'email']) || 'none',
    container_width: state.window_data.container_width,
    container_padding: state.window_data.container_padding,
    feed_width: state.window_data.feed_width,
    topics_by_id: state.topics.all_by_id,
    topics_by_name: state.topics.all_by_topic,
    subtopics_by_id: state.subtopics.all_by_id,
    subtopics_by_name: state.subtopics.all_by_subtopic,
    subtopic_to_topic: state.subtopics.subtopic_to_topic
  }
}

export default connect(mapStateToProps)(Body); 