class TheDailyBriefController < ApplicationController
  def home
  	@articles = Article.all
  end

  def top_stories
  end
end
