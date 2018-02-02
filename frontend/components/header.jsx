import React from 'react';
import SignInModal from './sign_in_modal.jsx';
import { SignOutButton } from "redux-auth/bootstrap-theme";
import { Link } from 'react-router';
import { browserHistory } from 'react-router';
import { DropdownButton, MenuItem } from 'react-bootstrap';
var logo_icon = require('../assets/images/logo-icon.svg');
var logo_text = require('../assets/images/logo-text.svg');

const Header = (props) => {
  // Set padding for header components
  const getHeaderStyle = () => {
    var padding = 20;

    if  ( props.container_padding > 0 ) {
      padding = props.container_padding;
    }

    var style = { 
      paddingLeft: padding + 'px',
      paddingRight: padding + 'px'
    }

    return style
  }

  // If user is not signed in, show Sign In / Sign Up option
  const getSignIn = () => {
    return (
      <div className="profile col-xs-5">
        <a className="green-text green-link right-align" onClick={props.handleShowModal}>Sign In / Sign Up</a>
        <SignInModal 
          show={props.showModal} 
          onHide={props.handleHideModal} 
          handleSignInSuccess={props.handleSignInSuccess} />
      </div>
    )
  }

  // If user is signed in, show drop down menu
  const getUserDropdown = () => {
    return (
      <div className="right-align">
        <DropdownButton 
          bsStyle='default' 
          className="user-dropdown" 
          title={props.user_name} 
          id='user-dropdown'
          onSelect={handleSelect}
        >
          <MenuItem eventKey="settings">Settings</MenuItem>
          <MenuItem divider />
          <MenuItem eventKey="sign-out" className="no-padding">
            <SignOutButton
              icon={null} 
              className="sign-out-button"
              next={props.handleSignOutSuccess}
            >
              Sign Out
            </SignOutButton>
          </MenuItem>
        </DropdownButton>
      </div>
    )
  }

  const handleSelect = ( eventKey ) => {
    if ( eventKey == "settings" ) {
      browserHistory.push('/settings');
    }
  }

  return (
    <header className="white-background no-margin">
      <div className="header width-100" style={getHeaderStyle()}>
        <div className="header-logo">
          <Link to="/">
            <div className="logo col-xs-7">
              <img src={logo_icon} alt=""/>
              <img src={logo_text} alt="The Daily Brief"/>
            </div>
          </Link>
          { props.signed_in ? getUserDropdown() : getSignIn() }
        </div>
      </div>
    </header>
  )
}

export default Header;