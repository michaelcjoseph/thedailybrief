import React from 'react';
import {connect} from 'react-redux';
import AboutUs from '../components/about_us.jsx';

class AboutUsContainer extends React.Component {
  render() {
    return (
      <AboutUs 
        container_width={this.props.container_width}
        container_padding={this.props.container_padding} 
        feed_width={this.props.feed_width} />
    )
  }
}

function mapStateToProps(state, ownProps) {
  return {
    container_width: state.window_data.container_width,
    container_padding: state.window_data.container_padding,
    feed_width: state.window_data.feed_width
  }
}

export default connect(mapStateToProps)(AboutUsContainer); 