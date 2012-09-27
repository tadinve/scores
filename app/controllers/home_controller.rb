class HomeController < ApplicationController
	
	before_filter :authenticate_user!

	def index
		@home_page = "This is home page of Score Application"
		@user = current_user
	end

	def about
		@about_page = "This is about page of Score Application"
	end

	def score
		@score = ScoreContent.last
	end

end