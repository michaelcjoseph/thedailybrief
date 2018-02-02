import React from 'react';
import ReactList from 'react-list';
import FeedItem from './feed_item.jsx';
import BannerContainer from '../containers/banner_container.jsx';

const FeedView = (props) => {
	const getStyle = () => {
		return { width: props.feed_width + 'px' }
	}

	var items = props.items.map(function(item, i) {
		return (
			<div key={i} className="col-xs-12">
				<FeedItem
					item={item}
					sources={props.sources}
					topics_by_id={props.topics_by_id}
					topics_by_name={props.topics_by_name}
					subtopics_by_id={props.subtopics_by_id}
          subtopics_by_name={props.subtopics_by_name}
          subtopic_to_topic={props.subtopic_to_topic}
					allow_set_topic={props.is_admin}
					handleClick={props.handleClick} 
					handleTopicSelect={props.handleTopicSelect} 
					handleSubtopicSelect={props.handleSubtopicSelect} />
			</div>
		)
	});

	const renderItem = (index, key) => {
		return items[index];
	}

	const itemSizeEstimator = (index, cache) => {
		if (items[index].image_url == '') {
			return 400
		}
		else {
			return 1000
		}
	}

	const renderFeed = () => {
		return (
			<ReactList
        itemRenderer={renderItem}
        length={items.length}
        type='variable'
        itemSizeEstimator={itemSizeEstimator}
      />
		)
	}

	const renderSignIn = () => {
		return (
			<div className="col-xs-12">
				{items[0]}
				<BannerContainer type={props.type} topic={props.topic} />
			</div>
		)
	}

	return (
		<div className="feed col-xs-12" style={getStyle()}>
			{(props.type == 'Topic' && !props.signed_in) ? renderSignIn() : renderFeed()}
		</div>
	)
}

export default FeedView;