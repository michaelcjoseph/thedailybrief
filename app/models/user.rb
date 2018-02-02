load 'sparkpost.rb'

class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  after_create :send_welcome_email

  def self.get_newsletter_user_emails( timerange )
    return User.select("DISTINCT email").where("email_status = ?", timerange)
  end

  def self.get_user_topics( user_email )
    user = User.where("email = ?", user_email)
    return user[0].topics
  end

  def self.update_email_status( id, email_status )
    user = User.find( id )
    user.email_status = email_status
    user.save
    return user
  end

  def self.update_books_status( id, status )
    user = User.find( id )
    user.books = status
    user.save
    return user
  end

  def self.update_topic_status( id, topic_id )
    user = User.find( id )

    if user.topics.include? topic_id
      user.topics.delete(topic_id)
    else
      user.topics.push(topic_id)
    end

    user.save
    return user
  end

  private

  def send_welcome_email
    user_first_name = self.name.split(' ')[0]

    Sparkpost.send_welcome_email( self.email, user_first_name )
  end
end
