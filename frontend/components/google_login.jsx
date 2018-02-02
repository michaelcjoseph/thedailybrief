import React from 'react';
import { OAuthSignInButton } from 'redux-auth/bootstrap-theme';

const GoogleLogin = (props) => {
  return (
    <OAuthSignInButton 
      provider="google"
      endpoint="default"
      icon={null}
      className="button-sign-in width-100 two-row-button google-button"
      next={props.handleSignInSuccess}
    >
      <div className="button-labelSet">
        <p className="button-label button-label-header white-button-text">Continue with Google</p>
        <p className="button-label button-label-subheader">We won't post without asking</p>
      </div>
    </OAuthSignInButton>
  )
}

export default GoogleLogin;