import React from 'react';
import { Link } from 'react-router';
import ItemSubHeader from './item_subheader.jsx';
import ItemImage from './item_image.jsx';
import ItemTopic from './item_topic.jsx';
import ItemFooter from './item_footer.jsx';

const FeedItem = (props) => {
  const handleItemClick = () => {
    props.handleClick(props.item);
  }
  
  const breakLine = (text) => {
    var br = React.createElement('br');
    var regex = /(<br \/>)/g;
    return text.split(regex).map(function(line, index) {
        return line.match(regex) ? <br key={"key_" + index} /> : line;
    });
  }

  const getItemBody = () => {
    var title = (
      <div className="item-title col-xs-12">
        <h2 className="bold-font no-margin">{props.item.title}</h2>
      </div>
    );

    var item_image = <ItemImage image_url={props.item.image_url} type={props.item.type} />;

    var snippet = (
      <div className="item-snippet col-xs-12">
        <p>{breakLine(props.item.snippet)}</p>
      </div>
    );

    var type = (
      <div className="col-xs-12 light-gray-text">
        <p>{props.item.type}</p>
      </div>
    )

    if ( props.item.type === 'Book' ) {
      return (
        <div>
          {title}
          {item_image}
          {snippet}
        </div>
      )
    } else {
      return (
        <a href={props.item.web_url} target="_blank" onClick={handleItemClick}>
          {title}
          {item_image}
          {snippet}
          {type}
        </a>
      )
    }
  }

  const getItemHeader = () => {
    if ( props.item.type == 'Article' || props.item.type == 'Podcast' ) {
      if ( props.sources.hasOwnProperty(props.item.header) ) {
        return (
          <Link to={"/" + props.sources[props.item.header].link_format}>
            <p className="green-text">{props.item.header}</p>
          </Link>
        )
      }
    }

    return (
      <p className="green-text">{props.item.header}</p>
    )
  }

  return (
    <div className="item col-xs-12">
      <div className="col-xs-12">
        <div className="col-xs-6">
          {getItemHeader()}
        </div>
        <ItemTopic
          item={props.item}
          topics_by_id={props.topics_by_id}
          topics_by_name={props.topics_by_name}
          subtopics_by_id={props.subtopics_by_id}
          subtopics_by_name={props.subtopics_by_name}
          subtopic_to_topic={props.subtopic_to_topic}
          allow_set_topic={props.allow_set_topic} 
          handleTopicSelect={props.handleTopicSelect} 
          handleSubtopicSelect={props.handleSubtopicSelect} />
      </div>
      
      <ItemSubHeader item={props.item} />

      {getItemBody()}

      <ItemFooter item={props.item} handleClick={props.handleClick}/>
    </div>
  )
}

export default FeedItem;