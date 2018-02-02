import React from 'react';
import {connect} from 'react-redux';
import { browserHistory } from 'react-router';
import Topics from '../components/topics.jsx';

class TopicsContainer extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      showSignInModal: false
    };
  }

  handleShowSignInModal() {
    this.setState({
      showSignInModal: true
    });
  }

  handleHideSignInModal() {
    this.setState({
      showSignInModal: false
    });
  }

  handleSignInSuccess() {
    this.setState({
      showSignInModal: false
    }); 

    browserHistory.push('/settings');
    window.location.reload();
  }

  render() {
    return (
      <Topics 
        container_width={this.props.container_width}
        container_padding={this.props.container_padding} 
        feed_width={this.props.feed_width} 
        showSignInModal={this.state.showSignInModal}
        handleHideSignInModal={this.handleHideSignInModal.bind(this)}
        handleShowSignInModal={this.handleShowSignInModal.bind(this)}
        handleSignInSuccess={this.handleSignInSuccess.bind(this)} />
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

export default connect(mapStateToProps)(TopicsContainer); 