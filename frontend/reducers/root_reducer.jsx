import { combineReducers } from 'redux'; 
import { authStateReducer } from 'redux-auth';
import { routerReducer } from 'react-router-redux';
import topics from './topic_reducer.jsx';
import subtopics from './subtopic_reducer.jsx';
import feed from './feed_reducer.jsx';
import books from './book_reducer.jsx';
import window_data from './window_data_reducer.jsx';

const rootReducer = combineReducers({  
  auth: authStateReducer,
  routing: routerReducer,
  topics,
  subtopics,
  feed,
  books,
  window_data
})

export default rootReducer;  