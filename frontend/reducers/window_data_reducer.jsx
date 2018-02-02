import * as types from '../actions/action_types.jsx';
import initialState from './initial_state.jsx';

const getContainerWidth = ( window_width ) => {
  if ( window_width > 1000 ) {
    return 1000
  } else if ( window_width > 700 ) {
    return 700
  } else {
    return window_width
  }
}

const getContainerPadding = ( window_width ) => {
  const container_width = getContainerWidth( window_width );

  if ( window_width > 700 ) {
    return (( window_width - container_width ) / 2 )
  } else {
    return 0
  }
}

const getFeedWidth = ( window_width ) => {
  if ( window_width > 700 ) {
    return 700
  } else {
    return window_width
  }
}

const getScrollLockStatus = ( scrollY ) => {
  if ( scrollY >= 70 ) {
    return true
  } else if ( scrollY < 70 ) {
    return false
  }
}

const getYPosition = ( scrollY ) => {
  if ( scrollY >= 70 ) {
    return 70
  } else if ( scrollY < 70 ) {
    return scrollY
  }
}

const windowDataReducer = ( state = initialState.window_data, action ) => {  
  switch( action.type ) {
    case types.WINDOW_RESIZE:
      var newState = Object.assign( {}, state );

      newState.width = action.window_width;
      newState.height = action.window_height;
      newState.container_width = getContainerWidth( action.window_width );
      newState.container_padding = getContainerPadding( action.window_width );
      newState.feed_width = getFeedWidth(action.window_width);

      return newState
    case types.WINDOW_SCROLL:
      var newState = Object.assign( {}, state );

      newState.scrollingLock = getScrollLockStatus( action.scrollY );
      newState.y_position = action.scrollY;

      return newState
    default: 
      return {
        width: window.innerWidth,
        height: window.innerHeight,
        container_width: getContainerWidth( window.innerWidth ),
        container_padding: getContainerPadding( window.innerWidth ),
        feed_width: getFeedWidth( window.innerWidth ),
        scrollingLock: false,
        y_position: 0
      }
  }
}

export default windowDataReducer;