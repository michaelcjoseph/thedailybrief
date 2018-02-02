import React, {PropTypes} from 'react';
import {connect} from 'react-redux';
import Body from './body.jsx';

class Latest extends React.Component {
  render() {
    return(
      <Body
        type={this.props.type ? this.props.type : 'Latest'}
        items={this.props.items}
        topic={this.props.topic}
        source={this.props.source}
        sources={this.props.sources}
      />
    )
  }
}

Latest.propTypes = {
  items: PropTypes.array.isRequired,
  sources: PropTypes.object.isRequired
};

function mapStateToProps(state, ownProps) {
  return {
    items: state.feed.latest,
    sources: state.feed.sources
  }
} 

export default connect(mapStateToProps)(Latest); 