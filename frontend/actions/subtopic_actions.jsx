import * as types from './action_types.jsx';
import SubtopicsApi from '../api/subtopics_api.jsx';

export const loadSubtopics = () => {  
  return ( dispatch ) => {
    return SubtopicsApi.getSubtopics( ( subtopics ) => {
      dispatch( loadSubtopicsSuccess( subtopics ));
    });
  };
}

export const loadSubtopicsSuccess = ( subtopics ) => {  
  return { type: types.LOAD_SUBTOPICS_SUCCESS, subtopics };
}