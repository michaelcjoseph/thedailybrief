import React from 'react';
import { SplitButton, MenuItem } from 'react-bootstrap';

const ItemTopic = (props) => {
  // Handler for when a drop down menu item is selected
  const handleTopicSelect = (topic_name) => {
    var topic_id = props.topics_by_name[ topic_name ];

    props.handleTopicSelect(props.item, topic_id);
  }

  const handleSubtopicSelect = (subtopic_name) => {
    var subtopic_id = props.subtopics_by_name[ subtopic_name ];

    props.handleSubtopicSelect(props.item, subtopic_id);
  }

  const renderDropDownMenuItem = (title, i) => {
    return (
      <MenuItem eventKey={title} key={i}>{title}</MenuItem>
    )
  }

  const getTopicDropDown = () => {
    // Create an array of strings with names of all topics
    const topics = Object.keys(props.topics_by_name);

    // Get the title of the drop down menu which defaults to
    // Select Topic unless a topic is already selected for the item
    var title = 'Select Topic';
    if ( props.item.topic_id ) {
      title = props.topics_by_id[ props.item.topic_id ]
    }

    return (
      <SplitButton title={title} id="topic-picker" onSelect={handleTopicSelect}>
        {topics.map(renderDropDownMenuItem)}
      </SplitButton>
    )
  }

  const getFilteredSubtopics = () => {
    var all_subtopics = Object.keys(props.subtopics_by_name);
    var filtered_subtopics = ["General"];

    if ( props.item.topic_id ) {
      for ( var i = 0; i < all_subtopics.length; i++ ) {
        if ( props.subtopic_to_topic[props.subtopics_by_name[all_subtopics[i]]] == props.item.topic_id ) {
          filtered_subtopics.push(all_subtopics[i])
        }
      }
      return filtered_subtopics
    } else {
      return all_subtopics
    }
  }

  const getSubtopicDropDown = () => {
    // Create an array of strings with names of all topics
    const subtopics = getFilteredSubtopics();

    // Get the title of the drop down menu which defaults to
    // Select Subtopic unless a topic is already selected for the item
    var title = 'Select Subtopic';
    if ( props.item.subtopic_id ) {
      title = props.subtopics_by_id[ props.item.subtopic_id ]
    }

    return (
      <SplitButton title={title} id="subtopic-picker" onSelect={handleSubtopicSelect}>
        {subtopics.map(renderDropDownMenuItem)}
      </SplitButton>
    )
  }

  const getTopicName = () => {
    var topic_name = ''
    if ( props.item.topic_id && props.topics_by_id ) {
      topic_name = props.topics_by_id[ props.item.topic_id ]
    }

    var subtopic_name = ''
    if ( props.item.subtopic_id && props.subtopics_by_id ) {
      subtopic_name = ': ' + props.subtopics_by_id[ props.item.subtopic_id ]
    }

    return (
      <p className="right-align">{topic_name}{subtopic_name}</p>
    )
  }

  const getTopic = () => {
    if ( props.allow_set_topic ) {
      return (
        <div className="col-xs-12">
          <div className="col-xs-6">
            {getTopicDropDown()}
          </div>
          <div className="col-xs-6">
            {getSubtopicDropDown()}
          </div>
        </div>
      )
    } else if ( props.item.topic_id ) {
      return getTopicName()
    }

    return null
  }

  var topic = getTopic();

  if ( topic ) {
    return (
      <div className="col-xs-6 light-gray-text right-align">
        {topic}
      </div>
    )
  }

  return null
}

export default ItemTopic;