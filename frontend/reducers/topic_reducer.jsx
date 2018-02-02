import * as types from '../actions/action_types.jsx';
import initialState from './initial_state.jsx';

const getFormattedTopics = ( topics ) => {
  var topics_dict_by_id = {
    0: "General"
  };
  var topics_dict_by_topic = {
    "General": 0
  }

  if ( topics ) {
    for ( var i = 0; i < topics.length; i++ ) {
      topics_dict_by_id[ topics[i].id ] = topics[i].topic;
      topics_dict_by_topic[ topics[i].topic ] = topics[i].id;
    }
  }

  return [ topics_dict_by_id, topics_dict_by_topic ];
}

const topicReducer = ( state = initialState.topics, action ) => {
  var topic_dicts = getFormattedTopics( action.topics );

  switch( action.type ) {
    case types.LOAD_TOPICS_SUCCESS:
      return {
        all_by_id: topic_dicts[0],
        all_by_topic: topic_dicts[1]
      }
    default: 
      return state;
  }
}

export default topicReducer;