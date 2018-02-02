import * as types from './action_types.jsx';
import PodcastsApi from '../api/podcasts_api.jsx';

export const loadPodcasts = () => {  
  return ( dispatch ) => {
    return PodcastsApi.getPodcasts( ( podcasts ) => {
      dispatch( loadPodcastsSuccess( podcasts ));
    });
  };
}

export const loadPodcastsSuccess = ( podcasts ) => {  
  return { type: types.LOAD_PODCASTS_SUCCESS, podcasts };
}