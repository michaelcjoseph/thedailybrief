import React, {PropTypes} from 'react';
import {connect} from 'react-redux';
import Body from './body.jsx';

class TopStories extends React.Component {
  render() {
    return(
      <Body
        type='Top Stories' 
        items={this.props.items}
        sources={this.props.sources}
      />
    )
  }
}

TopStories.propTypes = {
  items: PropTypes.array.isRequired,
  sources: PropTypes.object.isRequired
};

function mapStateToProps(state, ownProps) {
  return {
    items: state.feed.top_stories,
    sources: state.feed.sources
  }
} 

export default connect(mapStateToProps)(TopStories); 