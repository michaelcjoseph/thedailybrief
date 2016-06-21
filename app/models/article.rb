class Article < ActiveRecord::Base
	validates :source, presence: true
	validates :date, presence: true
	validates :web_url, presence: true, uniqueness: true
	validates :title, presence: true, uniqueness: true
	validates :snippet, presence: true, uniqueness: true
	validates :word_count, presence: true
	validates :views, presence: true
end
