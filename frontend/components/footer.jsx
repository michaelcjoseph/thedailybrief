import React from 'react';
import NavLink from './nav_link.jsx';

const Footer = () => {
	return (
		<div  className="col-xs-12 footer">
			<div className="footer-border"></div>
      <span className="footer-link small-font">
        <NavLink to="/about_us">About Us</NavLink>
      </span>
			<span className="footer-link small-font">
				<a title="Contact Us" href="mailto:michael@thedailybrief.co" target="_blank">Contact Us</a>
			</span>
		</div>
	)
}

export default Footer;