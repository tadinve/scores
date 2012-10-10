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
		@inning = Inning.last_inning

		# -2 for getting rid of extras and total records
		players = @inning.slice(0, @inning.count-2)
		graph_data = Array.new
		graph_data << ['Players', 'BR']
		players.each do |p|
			graph_data << [p.player_name, p.br]
		end

		@graph_data = graph_data
	end

end