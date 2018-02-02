import * as types from './action_types.jsx';
import BooksApi from '../api/books_api.jsx';

export const loadBooks = () => {  
  return ( dispatch ) => {
    return BooksApi.getBooks( ( books ) => {
      dispatch( loadBooksSuccess( books ));
    });
  };
}

export const loadBooksSuccess = ( books ) => {  
  return { type: types.LOAD_BOOKS_SUCCESS, books };
}