class Api::UserSettingsController < Api::BaseController
  def update_email_status
    user = User.update_email_status( params[:id], params[:email_status] )
    respond_with user, json: user
  end

  def update_books_status
    user = User.update_books_status( params[:id], params[:status] )
    respond_with user, json: user
  end

  def update_topic_status
    user = User.update_topic_status( params[:id], params[:topic_id].to_i )
    respond_with user, json: user
  end
end