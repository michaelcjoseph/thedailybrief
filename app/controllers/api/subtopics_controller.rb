class Api::SubtopicsController < Api::BaseController
  def index
    respond_with Subtopic.get_subtopics
  end
end