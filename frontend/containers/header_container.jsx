import React from 'react';
import {connect} from 'react-redux';
import { browserHistory } from 'react-router';
import Header from '../components/header.jsx';

class HeaderContainer extends React.Component {
  // On component creation, initialize variables
  constructor(props) {
    super(props);

    this.state = {
      showModal: false,
    };

    this.handleShowModal = this.handleShowModal.bind(this);
    this.handleHideModal = this.handleHideModal.bind(this);
    this.handleSignInSuccess = this.handleSignInSuccess.bind(this);
    this.handleSignOutSuccess = this.handleSignOutSuccess.bind(this);
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

    window.location.reload();
  }

  handleSignOutSuccess() {
    browserHistory.push('/');
  }

  render() {
    return (
      <Header 
        container_padding={this.props.container_padding} 
        signed_in={this.props.signed_in}
        user_name={this.props.user_name}
        showModal={this.state.showModal}
        handleHideModal={this.handleHideModal}
        handleShowModal={this.handleShowModal}
        handleSignInSuccess={this.handleSignInSuccess} 
        handleSignOutSuccess={this.handleSignOutSuccess}/>
    )
  }
}

function mapStateToProps(state, ownProps) {
  return {
    signed_in: state.auth.getIn(["user", "isSignedIn"]),
    user_name: state.auth.getIn(['user', 'attributes', 'name']) || 'none',
    container_padding: state.window_data.container_padding
  }
}

export default connect(mapStateToProps)(HeaderContainer); 