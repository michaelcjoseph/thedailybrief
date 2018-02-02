import * as types from './action_types.jsx';
import ArticlesApi from '../api/articles_api.jsx';

export const loadArticles = () => {  
  return ( dispatch ) => {
    return ArticlesApi.getArticles( ( articles ) => {
      dispatch( loadArticlesSuccess( articles ));
    });
  };
}

export const loadArticlesSuccess = ( articles ) => {  
  return { type: types.LOAD_ARTICLES_SUCCESS, articles };
}