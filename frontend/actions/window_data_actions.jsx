import * as types from './action_types.jsx';

export const windowResize = () => {  
  return {
    type: types.WINDOW_RESIZE, 
    window_width: window.innerWidth, 
    window_height: window.innerHeight
  };
}

export const windowScroll = () => {  
  return {
    type: types.WINDOW_SCROLL, 
    scrollY: window.scrollY
  };
}