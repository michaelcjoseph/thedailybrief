import * as types from '../actions/action_types.jsx';
import initialState from './initial_state.jsx';

const getFormattedArticles = ( articles ) => {
  var articles = articles.map( ( article ) => {
    return {
      id: article.id,
      web_url: article.web_url,
      title: article.title,
      snippet: article.snippet,
      image_url: article.image_url,
      header: article.source,
      sub_header: article.date,
      word_count: article.word_count,
      views: article.views,
      topic_id: article.topic_id,
      subtopic_id: article.subtopic_id,
      updated_at: article.updated_at,
      type: 'Article'
    }
  });

  return articles;
}

const getFormattedPodcasts = ( podcasts ) => {
  var podcasts = podcasts.map( ( podcast ) => {
    return {
      id: podcast.id,
      web_url: podcast.web_url,
      title: podcast.title,
      snippet: podcast.snippet,
      image_url: podcast.image_url,
      header: podcast.source,
      sub_header: podcast.date,
      duration: podcast.duration,
      views: podcast.views,
      topic_id: podcast.topic_id,
      subtopic_id: podcast.subtopic_id,
      updated_at: podcast.updated_at,
      type: 'Podcast'
    }
  });

  return podcasts;
}

const getSources = ( current_sources, items ) => {
  var new_sources = current_sources;

  for( var i = 0; i < items.length; i++ ) {
    var source = items[i].header;
    var source_link_format = items[i].header.toLowerCase().replace(/\s/g, "_");

    if( source in new_sources ) {
      new_sources[ source ].num_stories += 1;
    } else {
      new_sources[ source ] = {
        link_format: source_link_format,
        num_stories: 1
      }
    }
  }

  return new_sources
}

const compareItemTimeStamps = ( a, b ) => {
  if ( a.updated_at > b.updated_at ) {
    return -1;
  }
  else if ( a.updated_at < b.updated_at ) {
    return 1;
  }
  else {
    return compareItemTitles(a, b)
  }
}

const compareItemViews = ( a, b ) => {
  if ( a.views > b.views ) {
    return -1;
  }
  else if ( a.views < b.views ) {
    return 1;
  }
  else {
    return compareItemTitles(a, b)
  }
}

const compareItemTitles = ( a, b ) => {
  return a.title.localeCompare( b.title )
}

const updateStateItems = ( newState, latest, top_stories ) => {
  newState.latest = newState.latest.concat( latest );
  newState.top_stories = newState.top_stories.concat( top_stories );
  newState.sources = getSources(newState.sources, latest);

  newState.latest.sort( compareItemTimeStamps );
  newState.top_stories.sort( compareItemViews );

  return newState;
}

const feedReducer = ( state = initialState.feed, action ) => {  
  switch(action.type) {
    case types.LOAD_ARTICLES_SUCCESS:
      return updateStateItems(
        Object.assign( {}, state ),
        getFormattedArticles( action.articles[0]['feed'] ),
        getFormattedArticles( action.articles[0]['top_stories'] )
      );
    case types.LOAD_PODCASTS_SUCCESS:
      return updateStateItems(
        Object.assign( {}, state ),
        getFormattedPodcasts(action.podcasts[0]['feed']),
        getFormattedPodcasts(action.podcasts[0]['top_podcasts'])
      );
    default: 
      return state;
  }
}

export default feedReducer;