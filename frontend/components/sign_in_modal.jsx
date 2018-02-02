import React from 'react';
import ReactDOM from 'react-dom';
import { Modal } from 'react-bootstrap';
import FacebookLogin from './facebook_login.jsx';
import GoogleLogin from './google_login.jsx';
var logo_icon = require('../assets/images/logo-icon.svg');
var logo_text = require('../assets/images/logo-text.svg');

const SignInModal = (props) => {
  return (
    <Modal show={props.show} onHide={props.onHide}>
      <Modal.Header closeButton>
        <div className="modal-header-logo width-100">
          <div className="modal-header-logo-icon center-div">
            <img src={logo_icon} alt=""/>
          </div>
          <div className="modal-header-logo-text center-div">
            <img src={logo_text} alt="The Daily Brief"/>
          </div>
        </div>
      </Modal.Header>
      <Modal.Body>
        <div className="modal-body-main">
          <p className="modal-body-main-header">
            Sign up to access all stories and get our curated newsletter with 
            the most interesting stories of the day.
          </p>
          <br />
          <p className="modal-body-main-header">
            We recommend using an account with an email address you check.
          </p>
          <div className="sign-in">
            <GoogleLogin 
              onHide={props.onHide} 
              handleSignInSuccess={props.handleSignInSuccess} />
            <FacebookLogin 
              onHide={props.onHide} 
              handleSignInSuccess={props.handleSignInSuccess} />
          </div>
          <div className="modal-body-main-closer">
            <p>
              To use The Daily Brief, you must have cookies enabled.
            </p>
            <p>
              By signing up for The Daily Brief, you are subscribing to our daily
              newsletter. You can always change your preferences or unsubscribe 
              from the newsletter.
            </p>
          </div>
        </div>
      </Modal.Body>
    </Modal>
  )
}

export default SignInModal;