class Api::TopicsController < Api::BaseController
  def index
    respond_with Topic.get_topics
  end
end