import React from 'react';
import HeaderContainer from '../containers/header_container.jsx';
import SignInModal from './sign_in_modal.jsx'
import Footer from './footer.jsx';
import NavLink from './nav_link.jsx';

const Topics = (props) => {
  // Create style for settings page
  const getTopicsPageStyle = () => {
    var padding = (props.container_width - props.feed_width) / 2;

    if ( padding < 20 ) {
      padding = 20;
    }

    var style = { 
      width: props.container_width + 'px', 
      marginLeft: props.container_padding + 'px',
      marginRight: props.container_padding + 'px',
      paddingLeft: padding + 'px',
      paddingRight: padding + 'px'
    }

    return style
  }

  return (
    <div className="white-background">
      <HeaderContainer />
      <div className="padding-top40" style={getTopicsPageStyle()}>
        <NavLink to="/">
          <i className="fa fa-chevron-left dark-gray-text padding-top10 back-button"></i>
        </NavLink>
        <h1 className="bold-font large-h1-font">Topics</h1>
        <div className="padding-top40 bottom-border">
          <p className="dark-gray-text">
            Sign up for The Daily Brief to access content and newsletters
            organized by the following topics.
          </p>
        </div>
        <div className="col-xs-12 padding-top25 padding-bottom25">
          <div className="col-xs-4">
            <ul className="no-padding-left no-margin-left">
              <li className="white-button-text">
                <p className="dark-gray-text">
                  Politics
                </p>
              </li>
              <li className="white-button-text">
                <p className="dark-gray-text">
                  Business
                </p>
              </li>
              <li className="white-button-text">
                <p className="dark-gray-text">
                  Sports
                </p>
              </li>
              <li className="white-button-text">
                <p className="dark-gray-text">
                  Arts
                </p>
              </li>
              <li className="white-button-text">
                <p className="dark-gray-text">
                  Race & Culture
                </p>
              </li>
            </ul>
          </div>
          <div className="col-xs-4">
            <ul className="no-padding-left no-margin-left">
              <li className="white-button-text">
                <p className="dark-gray-text">
                  Technology
                </p>
              </li>
              <li className="white-button-text">
                <p className="dark-gray-text">
                  Science
                </p>
              </li>
              <li className="white-button-text">
                <p className="dark-gray-text">
                  Food
                </p>
              </li>
              <li className="white-button-text">
                <p className="dark-gray-text">
                  Travel
                </p>
              </li>
              <li className="white-button-text">
                <p className="dark-gray-text">
                  Education
                </p>
              </li>
            </ul>
          </div>
          <div className="col-xs-4">
            <ul className="no-padding-left no-margin-left">
              <li className="white-button-text">
                <p className="dark-gray-text">
                  Environment
                </p>
              </li>
              <li className="white-button-text">
                <p className="dark-gray-text">
                  Entertainment
                </p>
              </li>
              <li className="white-button-text">
                <p className="dark-gray-text">
                  Health
                </p>
              </li>
              <li className="white-button-text">
                <p className="dark-gray-text">
                  Gaming
                </p>
              </li>
            </ul>
          </div>
        </div>
        <div className="width-100 overflow-hidden">
          <div className="col-xs-6">
            <a 
              className="right-align main-menu-button small-font rounded-button green-background white-button-text light-font" 
              onClick={props.handleShowSignInModal}
            >
              Sign Up
            </a>
            <SignInModal 
              show={props.showSignInModal} 
              onHide={props.handleHideSignInModal} 
              handleSignInSuccess={props.handleSignInSuccess} />
          </div>
        </div>
        <Footer />
      </div>
    </div>
  )
}

export default Topics;