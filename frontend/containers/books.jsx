import React, {PropTypes} from 'react';
import {connect} from 'react-redux';
import Body from './body.jsx';

class Books extends React.Component {
  render() {
    return(
      <Body 
        type='Books'
        items={this.props.books} 
      />
    )
  }
}

Books.propTypes = {
  books: PropTypes.array.isRequired,
};

function mapStateToProps(state, ownProps) {
  return {
    books: state.books.feed
  }
} 

export default connect(mapStateToProps)(Books); 