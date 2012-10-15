class HomeController < ApplicationController
	require 'mechanize'
		
	before_filter :authenticate_user!

	def index
		@home_page = "This is home page of Score Application"
		@user = current_user
	end

	def about
		@about_page = "This is about page of Score Application"
	end

	def score
		if params[:url]
			agent = Mechanize.new
			url = params[:url]
			agent.get(url)

			match_id = Inning.count + 5

			innings1_bat = agent.page.search('#inningsBat1')
			innings2_bat = agent.page.search('#inningsBat2')
			batting_team1 = innings1_bat.search('.inningsHead td[2]').text
			batting_team2 = innings2_bat.search('.inningsHead td[2]').text

			rows = innings1_bat.search('.inningsRow')

			# calculating team1 statistics.
			avg_strike_rate = 0.0
			total_minutes = 0
			total_balls = 0
			total_fours = 0
			total_sixes = 0
			total_runs = 0
			rows.each_with_index do |row,index|
				record = row.text
				r = record.split("\n")
				r = r.slice(1, 10)
				total_minutes += r[3].to_i
				total_balls += r[4].to_i
				total_fours += r[5].to_i
				total_sixes += r[6].to_i
				if rows.count-1 == index
					total_runs = r[2].to_i
				end
			end
			
			avg_strike_rate = ((total_runs.to_f/total_balls.to_f)*100).round(2)

			rows.each do |row|
				record = row.text
				r = record.split("\n")
				r = r.slice(1, 10)	
				bc = (r[7].to_f/avg_strike_rate).round(2)
				sc = (r[2].to_f/total_runs).round(2)
				br = (bc*sc*100).round(2)

				Inning.create( :match_id => match_id, :team => batting_team1, :player_name => r[0], :status => r[1], :runs => r[2].to_i, :minutes => r[3].to_i, :balls => r[4].to_i, :fours => r[5].to_i, :sixes => r[6].to_i, :strike_rate => r[7].to_f, :bc => bc, :sc => sc, :br => br )
			end

			# updating total stats
			total = Inning.where(:match_id => match_id).last
			total.update_attributes( :minutes => total_minutes, :balls => total_balls, :fours => total_fours, :sixes => total_sixes, :strike_rate => avg_strike_rate, :bc => 1.0, :sc => 1.0, :br => 100.0 )

			# ===============================================================================
			# team 2 statistics starts.......................................................
			# ===============================================================================

			rows = innings2_bat.search('.inningsRow')

			# calculating team1 statistics.
			avg_strike_rate = 0.0
			total_minutes = 0
			total_balls = 0
			total_fours = 0
			total_sixes = 0
			total_runs = 0
			rows.each_with_index do |row,index|
				record = row.text
				r = record.split("\n")
				r = r.slice(1, 10)
				total_minutes += r[3].to_i
				total_balls += r[4].to_i
				total_fours += r[5].to_i
				total_sixes += r[6].to_i
				if rows.count-1 == index
					total_runs = r[2].to_i
				end
			end
			
			avg_strike_rate = ((total_runs.to_f/total_balls.to_f)*100).round(2)

			rows.each do |row|
				record = row.text
				r = record.split("\n")
				r = r.slice(1, 10)	
				bc = (r[7].to_f/avg_strike_rate).round(2)
				sc = (r[2].to_f/total_runs).round(2)
				br = (bc*sc*100).round(2)

				Inning.create( :match_id => match_id, :team => batting_team2, :player_name => r[0], :status => r[1], :runs => r[2].to_i, :minutes => r[3].to_i, :balls => r[4].to_i, :fours => r[5].to_i, :sixes => r[6].to_i, :strike_rate => r[7].to_f, :bc => bc, :sc => sc, :br => br )
			end

			# updating total stats
			total = Inning.where(:match_id => match_id).last
			total.update_attributes( :minutes => total_minutes, :balls => total_balls, :fours => total_fours, :sixes => total_sixes, :strike_rate => avg_strike_rate, :bc => 1.0, :sc => 1.0, :br => 100.0 )

			# ===============================================================================
			# after scraping code............................................................
			# ===============================================================================

			@inning1 = Inning.last_inning(batting_team1)

			# -2 for getting rid of extras and total records
			players = @inning1.slice(0, @inning1.count-2)
			graph_data = Array.new
			graph_data << ['Players', 'BR']
			players.each do |p|
				graph_data << [p.player_name, p.br]
			end
			@graph_data1 = graph_data

			@inning2 = Inning.last_inning(batting_team2)

			# -2 for getting rid of extras and total records
			players = @inning2.slice(0, @inning2.count-2)
			graph_data = Array.new
			graph_data << ['Players', 'BR']
			players.each do |p|
				graph_data << [p.player_name, p.br]
			end
			@graph_data2 = graph_data
		end
	end

end