import * as types from '../actions/action_types.jsx';
import initialState from './initial_state.jsx';

const getFormattedSubtopics = ( subtopics ) => {
  var subtopics_dict_by_id = {
    0: "General"
  };

  var subtopics_dict_by_subtopic = {
    "General": 0
  }

  var subtopic_to_topic = {}

  if ( subtopics ) {
    for ( var i = 0; i < subtopics.length; i++ ) {
      subtopics_dict_by_id[ subtopics[i].id ] = subtopics[i].subtopic;
      subtopics_dict_by_subtopic[ subtopics[i].subtopic ] = subtopics[i].id;
      subtopic_to_topic[ subtopics[i].id ] = subtopics[i].topic_id
    }
  }

  return [ 
    subtopics_dict_by_id, 
    subtopics_dict_by_subtopic, 
    subtopic_to_topic
  ];
}

const subtopicReducer = ( state = initialState.subtopics, action ) => {
  var subtopic_dicts = getFormattedSubtopics( action.subtopics );

  switch( action.type ) {
    case types.LOAD_SUBTOPICS_SUCCESS:
      return {
        all_by_id: subtopic_dicts[0],
        all_by_subtopic: subtopic_dicts[1],
        subtopic_to_topic: subtopic_dicts[2]
      }
    default: 
      return state;
  }
}

export default subtopicReducer;