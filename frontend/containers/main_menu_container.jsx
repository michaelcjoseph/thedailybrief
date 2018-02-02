import React from 'react';
import {connect} from 'react-redux';
import MainMenu from '../components/main_menu.jsx';

class MainMenuContainer extends React.Component {
  // On component creation, initialize variables
  constructor(props) {
    super(props);

    this.state = {
      showSignInModal: false,
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

    window.location.reload();
  }

  render() {
    return (
      <MainMenu
        signed_in={this.props.signed_in}
        source={this.props.source}
        container_padding={this.props.container_padding} 
        scrollingLock={this.props.scrollingLock}
        showSignInModal={this.state.showSignInModal}
        handleHideSignInModal={this.handleHideSignInModal.bind(this)}
        handleShowSignInModal={this.handleShowSignInModal.bind(this)}
        handleSignInSuccess={this.handleSignInSuccess.bind(this)} 
        user_topics={this.props.user_topics}
        topics_by_id={this.props.topics_by_id}
        topics_by_name={this.props.topics_by_name} />
    )
  }
}

function mapStateToProps(state, ownProps) {
  return {
    signed_in: state.auth.getIn(["user", "isSignedIn"]),
    user_topics: state.auth.getIn(['user', 'attributes', 'topics']) || [],
    topics_by_id: state.topics.all_by_id,
    topics_by_name: state.topics.all_by_topic,
    container_padding: state.window_data.container_padding,
    scrollingLock: state.window_data.scrollingLock
  }
}

export default connect(mapStateToProps)(MainMenuContainer); 