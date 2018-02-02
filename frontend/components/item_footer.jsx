import React from 'react';

const ItemFooter = (props) => {
  const handleReviewClick = () => {
    props.handleClick(props.item, 'Review');
  }

  const handleAmazonClick = () => {
    props.handleClick(props.item, 'Amazon');
  }

  if( props.item.type === 'Book' ) {
    return (
      <div className="item-footer col-xs-12">
        <a 
          href={props.item.review_url} 
          target="_blank" 
          onClick={handleReviewClick} 
          className="item-footer-button rounded-button review-button"
        >
          Read Review
        </a>
        <a 
          href={props.item.amazon_url} 
          target="_blank" 
          onClick={handleAmazonClick}
          className="item-footer-button rounded-button green-background white-button-text amazon-button"
        >
          Buy Book
        </a>
      </div>
    )
  }

  return null
}

export default ItemFooter;