import React from 'react';
import { ButtonGroup, Button } from 'react-bootstrap';
import HeaderContainer from '../containers/header_container.jsx';
import Footer from './footer.jsx';
import NavLink from './nav_link.jsx';

const Settings = (props) => {
  // Create style for settings page
  const getSettingsPageStyle = () => {
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

  const handleGeneralEmailToggle = (timeframe) => {
    props.handleGeneralEmailToggle(timeframe);
  }

  const handleTopicsToggle = (topic) => {
    props.handleTopicsToggle(props.topics_by_name[topic])
  }

  const getSectionHeader = (section_title) => {
    return (
      <div className="col-xs-12 padding-top40 bottom-border">
        <p className="light-gray-text">{section_title}</p>
      </div>
    )
  }

  const getListItem = (title, desc, disabled, onClick, i=0) => {
    return (
      <li className="col-xs-12 settings-list-item" key={i}>
        <div className="col-xs-8 settings-list-desc">
          <h4 className="bold-font dark-gray-text padding-bottom5">
            {title}
          </h4>
          <p className="light-gray-text">
            {desc} 
          </p>
        </div>
        <div className="col-xs-4">
          <ButtonGroup className="right-align">
            <Button 
              className="rounded-button button-toggle light-font" 
              disabled={disabled ? true : false}
              onClick={onClick}
            >
              On
            </Button>
            <Button 
              className="rounded-button button-toggle light-font"
              disabled={disabled ? false : true}
              onClick={onClick}
            >
              Off
            </Button>
          </ButtonGroup>
        </div>
      </li>
    )
  }

  const renderTopicSettingItem = (title, i) => {
    var desc = "You'll be able to see stories categorized under " + title + " in one feed. Your newsletter will also have a section dedicated to new stories in " + title + " from various publications";
    var disabled = props.user_topics.indexOf(props.topics_by_name[title]) > -1;
    var onClick = () => handleTopicsToggle(title);

    return getListItem(title, desc, disabled, onClick, i);
  }

  const getAllTopicSettings = () => {
    // Create an array of strings with names of all topics
    var topics = Object.keys(props.topics_by_name);
    var index = topics.indexOf("General");

    if (index > -1) {
      topics.splice(index, 1);
    }

    return (
      <ul className="col-xs-12 no-padding-left no-margin-left">
        {topics.map(renderTopicSettingItem)}
      </ul>
    )
  }

  return (
    <div className="white-background">
      <HeaderContainer />
      <div className="col-xs-12 padding-top40" style={getSettingsPageStyle()}>
        <NavLink to="/">
          <i className="fa fa-chevron-left dark-gray-text padding-top10 back-button"></i>
        </NavLink>
        <h1 className="col-xs-12 bold-font large-h1-font">Settings</h1>
        {getSectionHeader("Email Settings")}
        <ul className="col-xs-12 no-padding-left no-margin-left">
          <li className="col-xs-12 settings-list-item">
            <div className="col-xs-8 settings-list-desc">
              <h4 className="bold-font dark-gray-text padding-bottom5">
                Today's Daily Brief
              </h4>
              <p className="light-gray-text">
                We’ll email you with new stories from various publications.
              </p>
            </div>
            <div className="col-xs-4">
              <ButtonGroup className="right-align">
                <Button 
                  className="rounded-button button-toggle light-font" 
                  disabled={props.general_email == 'daily' ? true : false}
                  onClick={() => handleGeneralEmailToggle('daily')}
                >
                  Daily
                </Button>
                <Button 
                  className="rounded-button button-toggle light-font"
                  disabled={props.general_email == 'weekly' ? true : false}
                  onClick={() => handleGeneralEmailToggle('weekly')}
                >
                  Weekly
                </Button>
                <Button 
                  className="rounded-button button-toggle light-font"
                  disabled={props.general_email == 'off' ? true : false}
                  onClick={() => handleGeneralEmailToggle('off')}
                >
                  Off
                </Button>
              </ButtonGroup>
            </div>
          </li>
          {
            getListItem(
              "Books",
              "We'll email you (never more than once a week) when we have a new book review.",
              props.books,
              props.handleBooksToggle
            )
          }
        </ul>
        {getSectionHeader("Topic Settings")}
        <ul className="col-xs-12 no-padding-left no-margin-left">
          {getAllTopicSettings()}
        </ul>
        <NavLink to="/">
          <div className="center-div banner-button-div col-xs-12">
            <div className="banner-button rounded-button">
              Back to Home
            </div>
          </div>
        </NavLink>
        <Footer />
      </div>
    </div>
  )
}

export default Settings;