import * as types from './action_types.jsx';
import TopicsApi from '../api/topics_api.jsx';

export const loadTopics = () => {  
  return ( dispatch ) => {
    return TopicsApi.getTopics( ( topics ) => {
      dispatch( loadTopicsSuccess( topics ));
    });
  };
}

export const loadTopicsSuccess = ( topics ) => {  
  return { type: types.LOAD_TOPICS_SUCCESS, topics };
}