require 'test_helper'

class TheDailyBriefControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get top_stories" do
    get :top_stories
    assert_response :success
  end

end
