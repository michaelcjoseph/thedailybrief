class Api::BooksController < Api::BaseController
  def index
    respond_with Book.get_books
  end

  def update_views
    book_id = params[:id]

    if params[:button] == 'Review'
      book = Book.update_review_views( book_id )
    elsif params[:button] == 'Amazon'
      book = Book.update_amazon_views( book_id )
    end

    respond_with book, json: book
  end

  def update_topic
    book = nil
    
    if params[:type] == 'topic'
      book = Book.update_topic( params[:id], params[:topic_id] )
    elsif params[:type] == 'subtopic'
      book = Book.update_subtopic( params[:id], params[:subtopic_id] )
    end

    respond_with book, json: book
  end
end