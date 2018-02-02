class Book < ActiveRecord::Base
  validates :genre, presence: true
  validates :author, presence: true
  validates :title, presence: true, uniqueness: true
  validates :snippet, presence: true, uniqueness: true
  validates :review_url, presence: true, uniqueness: true
  validates :amazon_url, presence: true, uniqueness: true
  validates :review_views, presence: true
  validates :amazon_views, presence: true

  def self.get_books
    feed = Book.all
    top_books = Book.get_top_books

    return [{
      feed: feed,
      top_books: top_books
    }]
  end

  def self.get_recent_book
    return Book.all.order(created_at: :desc).limit(1)
  end

  def self.get_top_books
    return Book.all.order(review_views: :desc).limit(5)
  end

  def self.update_review_views( id )
    book = Book.find( id )
    book.review_views += 1
    book.save
    return book
  end

  def self.update_amazon_views( id )
    book = Book.find( id )
    book.amazon_views += 1
    book.save
    return book
  end

  def self.update_topic( id, topic_id )
    book = Book.find( id )
    
    if topic_id == '0'
      book.topic_id = nil
    else
      book.topic_id = topic_id
    end
    
    book.save
    return book
  end

  def self.update_subtopic( id, subtopic_id )
    book = Book.find( id )

    if subtopic_id == '0'
      book.subtopic_id = nil
    else
      book.subtopic_id = subtopic_id
    end

    book.save
    return book
  end
end
