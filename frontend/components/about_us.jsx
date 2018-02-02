import React from 'react';
import HeaderContainer from '../containers/header_container.jsx';
import Footer from './footer.jsx';
import NavLink from './nav_link.jsx';

const AboutUs = (props) => {
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
        <h1 className="bold-font large-h1-font">About Us</h1>
        <div className="padding-top40 large-font">
          <p className="dark-gray-text">
            Hi! My name is Michael Joseph and I started The Daily Brief to 
            better curate news for myself. Before this, I was using Facebook
            as my primary means of finding articles to read. Though I would 
            find some interesting articles, it also meant I was getting a
            specific perspective on some topics and missing out on other
            topics of interest entirely. Hence The Daily Brief.
          </p>
          <p className="dark-gray-text padding-top25">
            The Daily Brief goes through a number of different sources 
            (currently ~70) and pulls their most recent articles that are over
            1,000 words in length. These are categorized by topic and displayed
            on the site.
          </p>
          <p className="dark-gray-text padding-top25">
            There's also a newsletter that you can subscribe to on the site.
            The newsletter has a general section of interesting stories along
            with the top stories in each topic that you have subscribed to. 
            The algorithm for picking the articles is a combination of me and 
            the computer.
          </p>
          <p className="dark-gray-text padding-top25 padding-bottom25">
            The Daily Brief is meant to make it easier to find quality stories 
            that better inform and educate the reader. It's certainly done that
            for me, and I hope you find that it does the same for you. Cheers!
          </p>
        </div>
        <Footer />
      </div>
    </div>
  )
}

export default AboutUs;