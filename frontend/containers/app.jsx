import React from 'react';
import {connect} from 'react-redux';
import { AuthGlobals } from "redux-auth/bootstrap-theme";
import { windowResize, windowScroll } from '../actions/window_data_actions.jsx'; 

class App extends React.Component {	
  constructor(props) {
    super(props);

    this.state = {
      prevPath: '',
    };
  }

  componentWillReceiveProps(nextProps) {
    if (nextProps.location !== this.props.location) {
      this.setState({ prevPath: this.props.location })
    }
  }

	// Once component is loaded, set up actions for resize and scroll
	componentDidMount() {
    window.addEventListener('resize', this.props.onWindowResize);
    window.addEventListener('scroll', this.props.onWindowScroll);
  }

  // Remove event listeners initialized
	componentWillUnmount() {
    window.removeEventListener('resize', this.props.onWindowResize);
    window.removeEventListener('scroll', this.props.onWindowScroll);
  }

	render() {
    if (this.state.prevPath.pathname == '/settings') {
      window.location.reload();
    }
    
		return ( 
			<div>
        <AuthGlobals />
        {React.cloneElement(
          this.props.children
        )}
			</div>
		)
	}
}

function mapStateToProps(state, ownProps) {
  return {}
}

function mapDispatchToProps(dispatch) {
  return {
    onWindowResize: function() { dispatch(windowResize()) },
    onWindowScroll: function() { dispatch(windowScroll()) }
  };
}

export default connect(mapStateToProps, mapDispatchToProps)(App); 