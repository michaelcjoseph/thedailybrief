import React from 'react';
import { Link } from 'react-router';

const SourcesMenu = (props) => {
  const getSources = () => {
    var sources = [];
    var count = 0;

    for ( var key in props.sources ) {
      if ( props.sources.hasOwnProperty(key) ) {
        sources.push(
          <Link className="link-no-decoration" to={'/' + props.sources[key].link_format} key={count}>
            <li className='sources-menu-item inline-block center-div'>
              <h4 className="bold-font black-text">{key}</h4>
              <p className="small-font dark-gray-text">{props.sources[key].num_stories} {props.sources[key].num_stories > 1 ? "Stories" : "Story"}</p>
            </li>
          </Link>
        );
      }

      count++;
    }

    return sources;
  }

  return (
    <div className="overflow-hidden">
      <ul className="menu-bar">
        {getSources()}
      </ul>
    </div>
  )
}

export default SourcesMenu;