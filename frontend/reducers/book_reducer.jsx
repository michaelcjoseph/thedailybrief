import * as types from '../actions/action_types.jsx';
import initialState from './initial_state.jsx';

const getFormattedBooks = ( books ) => {
  var books = books.map( ( book ) => {
    return {
      id: book.id,
      title: book.title,
      snippet: book.snippet,
      image_url: book.image_url,
      header: book.genre,
      sub_header: book.author,
      review_url: book.review_url,
      amazon_url: book.amazon_url, 
      topic_id: book.topic_id,
      subtopic_id: book.subtopic_id,
      type: 'Book'
    }
  });

  return books;
}

const bookReducer = ( state = initialState.books, action ) => {  
  switch( action.type ) {
    case types.LOAD_BOOKS_SUCCESS:
      return {
        feed: getFormattedBooks( action.books[0]['feed'] )
      }
    case types.UPDATE_BOOK_TOPIC:
      var newState = Object.assign( {}, state );

      var item_index = newState.feed.indexOf(action.item);
      if (item_index > -1) {
        newState.feed[item_index].topic_id = action.topic_id;
      }

      return newState;
    case types.UPDATE_BOOK_SUBTOPIC:
      var newState = Object.assign( {}, state );

      var item_index = newState.feed.indexOf(action.item);
      if (item_index > -1) {
        newState.feed[item_index].subtopic_id = action.subtopic_id;
      }

      return newState;
    default: 
      return state;
  }
}

export default bookReducer;