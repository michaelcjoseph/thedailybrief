import React from 'react';
import NavLink from './nav_link.jsx';
import SignInModal from './sign_in_modal.jsx'

const MainMenu = (props) => {
  // Lock or unlock top menu
  const lockMenuOnScroll = () => {
    var style = { position: 'relative' };

    if ( props.scrollingLock ) {
      style = { 
        position: 'fixed',
        top: 0,
        zIndex: 100 
      };
    }

    return style
  }

  // Set padding for header components
  const getHeaderStyle = () => {
    var padding = 20;

    if  ( props.container_padding > 0 ) {
      padding = props.container_padding;
    }

    var style = { 
      paddingLeft: padding + 'px',
      paddingRight: padding + 'px'
    };

    return style
  }

  // Determine if sign in button should be shown in nav bar
  const getSignInButton = () => {
    return (
      <div className="col-xs-4 col-sm-2 col-md-2 main-menu-button-div">
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
    )
  }

  const getTopicsMenuItems = (topic, i) => {
    if (!props.signed_in || (props.user_topics.indexOf(props.topics_by_name[topic]) > -1)) {
      var url = topic == 'Race & Culture' ? 'race' : topic.toLowerCase();
      return (
        <li className="menu-bar-item inline-block" key={i}>
          <NavLink to={"/" + url}>{topic}</NavLink>
        </li>
      )
    }
  }

  const getNavBar = () => {
    var ul_class_names = '';
    var sign_in_button = null;

    if ( !props.signed_in && props.scrollingLock ) {
      ul_class_names = "col-xs-8 col-sm-10 col-md-10 menu-bar no-margin text-align-left";
      sign_in_button = getSignInButton();
    } else {
      ul_class_names = "col-xs-12 menu-bar no-margin text-align-left";
    }

    // Create an array of strings with names of all topics
    var topics = Object.keys(props.topics_by_name);
    var index = topics.indexOf("General");

    if (index > -1) {
      topics.splice(index, 1);
    }

    return (
      <div className="navbar-menu width-100 overflow-hidden">
        <ul className={ul_class_names}>
          <li className="menu-bar-item inline-block">
            <NavLink to="/" onlyActiveOnIndex={true}>Top Stories</NavLink>
          </li>
          <li className="menu-bar-item inline-block">
            <NavLink to="/latest">Latest</NavLink>
          </li>
          <li className="menu-bar-item inline-block">
            <NavLink to="/books">Books</NavLink>
          </li>
          {topics.map(getTopicsMenuItems)}
          <li className="menu-bar-item inline-block">
            <NavLink to={props.signed_in ? "/settings" : "/topics"}>
              <i className="fa fa-plus-circle add-topic-button"></i>
            </NavLink>
          </li>
        </ul>
        {sign_in_button}
      </div>
    )
  }

  const getSourceHeader = () => {
    return (
      <div className="width-100">
        <div className="col-xs-1">
          <NavLink to="/latest">
            <i className="fa fa-chevron-left dark-gray-text padding-top10 back-button"></i>
          </NavLink>
        </div>
        <div className="col-xs-10 center-div">
          <h3 className="bold-font no-bottom-margin source-title dark-gray-text">{props.source}</h3>
        </div>
      </div>
    )
  }

  return (
    <header className="header-navbar white-background width-100" style={lockMenuOnScroll()}>
      <div className="width-100" style={getHeaderStyle()}>
        {props.source ? getSourceHeader() : getNavBar()}
      </div>
    </header>
  )
}

export default MainMenu;