import {createStore, applyMiddleware} from 'redux';  
import rootReducer from '../reducers/root_reducer.jsx';  
import thunk from 'redux-thunk';

export default function configureStore() {  
  return createStore(
    rootReducer,
    applyMiddleware(thunk)
  );
}