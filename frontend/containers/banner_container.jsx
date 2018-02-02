import React from 'react';
import {connect} from 'react-redux';
import { browserHistory } from 'react-router';
import SignInBanner from '../components/sign_in_banner.jsx';

class BannerContainer extends React.Component {
  // On component creation, initialize variables
  constructor(props) {
    super(props);

    this.state = {
      showModal: false,
    };

    this.handleShowModal = this.handleShowModal.bind(this);
    this.handleHideModal = this.handleHideModal.bind(this);
    this.handleSignInSuccess = this.handleSignInSuccess.bind(this);
  }

  handleShowModal(){
    this.setState({
      showModal: true
    });
  }

  handleHideModal(){
    this.setState({
      showModal: false
    });
  }

  handleSignInSuccess() {
    this.setState({
      showModal: false
    });

    browserHistory.push('/settings');
    window.location.reload();
  }

  render() {
    if (!this.props.signed_in) {
      return (
        <SignInBanner 
          type={this.props.type}
          topic={this.props.topic}
          showModal={this.state.showModal}
          handleHideModal={this.handleHideModal}
          handleShowModal={this.handleShowModal}
          handleSignInSuccess={this.handleSignInSuccess} 
          container_width={this.props.container_width}
          container_padding={this.props.container_padding} />
      )
    }
    return null
  }
}

function mapStateToProps(state, ownProps) {
  return {
    signed_in: state.auth.getIn(["user", "isSignedIn"]),
    user_created_at: state.auth.getIn(['user', 'attributes', 'created_at']) || null,
    container_width: state.window_data.container_width,
    container_padding: state.window_data.container_padding
  }
}

export default connect(mapStateToProps)(BannerContainer); 