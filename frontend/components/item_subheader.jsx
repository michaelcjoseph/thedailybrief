import React from 'react';

const ItemSubHeader = (props) => {
  const getDate = (date) => {
    var date_str = date.toString()

    var year_str = ""
    var month_num = ""
    var month_str = ""
    var day_str = ""

    for ( var i = 0; i < date_str.length; i++ ) {
      if ( i < 4 ) {
        year_str += date_str[i]
      } else if ( i < 6 ) {
        month_num += date_str[i]
      } else if ( i >= 6 ) {
        day_str += date_str[i]
      }
    }

    switch( month_num ) {
      case "01":
        month_str = "Jan";
        break;
      case "02":
        month_str = "Feb";
        break;
      case "03":
        month_str = "Mar";
        break;
      case "04":
        month_str = "Apr";
        break;
      case "05":
        month_str = "May";
        break;
      case "06":
        month_str = "Jun";
        break;
      case "07":
        month_str = "Jul";
        break;
      case "08":
        month_str = "Aug";
        break;
      case "09":
        month_str = "Sep";
        break;
      case "10":
        month_str = "Oct";
        break;
      case "11":
        month_str = "Nov";
        break;
      case "12":
        month_str = "Dec";
        break;
    }

    return (month_str + " " + day_str + ", " + year_str)
  }

  const getTimeRead = (word_count) => {
    return Math.round( word_count / 250 )
  }

  const getTimeListen = (duration) => {
    return Math.round( duration / 60 )
  }
  
  var sub_header = isNaN(+props.item.sub_header) ? props.item.sub_header : getDate(props.item.sub_header);
  var time = null;

  if( props.item.type === 'Article' ) {
    time = ' · '  + getTimeRead( props.item.word_count ) + ' min read';
  } else if( props.item.type === 'Podcast' ) {
    time = ' · ' + getTimeListen( props.item.duration ) + ' min listen';
  }

  return ( 
    <div className="col-xs-12 item-sub-header small-font light-gray-text">
      <p>{sub_header}{time}</p>
    </div>
  )
}

export default ItemSubHeader;