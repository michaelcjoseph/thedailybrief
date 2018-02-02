import React from 'react';
import { OAuthSignInButton } from 'redux-auth/bootstrap-theme';

const FacebookLogin = (props) => {
  return (
    <OAuthSignInButton 
      provider="facebook"
      endpoint="default"
      icon={null}
      className="button-sign-in width-100 two-row-button facebook-button"
      next={props.handleSignInSuccess}
    >
      <div className="button-labelSet">
        <p className="button-label button-label-header white-button-text">Continue with Facebook</p>
        <p className="button-label button-label-subheader">We won't post without asking</p>
      </div>
    </OAuthSignInButton>
  )
}

export default FacebookLogin;