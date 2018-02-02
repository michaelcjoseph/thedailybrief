import React from 'react';

const ItemImage = (props) => {
  if( props.image_url.length > 0 ) {
    var image_class = props.type == "Book" ? "width-25" : "width-100";

    return (
      <div className="item-image col-md-12">
        <img className={image_class} src={props.image_url} />
      </div>
    )
  }

  return null
}

export default ItemImage;