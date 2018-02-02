import React from 'react';
import SignInModal from './sign_in_modal.jsx'

const SignInBanner = (props) => {
  // Determine left and right padding of banner based on size of window
  const getBannerPadding = () => {
    var padding = props.type == 'Topic' ? 20 : props.container_padding
    return {
      paddingLeft: padding + 'px',
      paddingRight: padding + 'px'
    };
  }

  const getHeader = () => {
    if (props.type == 'Topic') {
      return 'Access more stories about ' + props.topic + '.';
    } else {
      return 'Stories for curious minds.';
    }
  }

  const getSubHeader = () => {
    var style = {};
    if (props.container_padding == 0) {
      style = {
        marginBottom: 20 + 'px'
      };
    }

    if (props.type == 'Topic') {
      return (
        'Sign up for The Daily Brief to get access to all ' + 
        props.topic + ' stories and to have the most ' +
        'interesting stories in ' + props.topic +
        ' curated in your newsletter.'
      )
    } else {
      return (
        <div className="col-xs-12">
          <div className="col-xs-12" style={style}>
            The Daily Brief curates longer form articles and podcasts from high 
            quality, handpicked sources.
          </div>
          <div className="col-xs-12">
            Sign up to access all stories and get our curated newsletter with the 
            most interesting stories of the day.
          </div>
        </div>
      );
    }
  }

  return (
    <div className="sign-in-banner col-xs-12" id="sign-in-banner" style={getBannerPadding()}>
      <h1 className="banner-header bold-font center-div no-top-margin col-xs-12">
        {getHeader()}
      </h1>
      <div className="banner-subheader body-font light-font center-div no-top-margin col-xs-12">
        {getSubHeader()}
      </div>
      <div className="center-div banner-button-div col-xs-12">
        <a className="banner-button rounded-button green-background white-button-text" onClick={props.handleShowModal}>
          Get Started
        </a>
      </div>
      <SignInModal 
        show={props.showModal} 
        onHide={props.handleHideModal} 
        handleSignInSuccess={props.handleSignInSuccess} />
    </div>
  )
}

export default SignInBanner;