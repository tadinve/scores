desc "Fetching Score from CricInfo.comTask description"
task :fetch_score => :environment do
	
	require 'mechanize'

	agent = Mechanize.new
	url = "http://www.espncricinfo.com/icc-world-twenty20-2012/engine/current/match/533298.html"
	agent.get(url)

	innings1_bat = agent.page.search('#inningsBat1')
	batting_team = innings1_bat.search('.inningsHead td[2]').text

	rows = innings1_bat.search('.inningsRow')

	# calculating team statistics.
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
	match_id = Inning.count + 5
	avg_strike_rate = ((total_runs.to_f/total_balls.to_f)*100).round(2)

	rows.each do |row|
		record = row.text
		r = record.split("\n")
		r = r.slice(1, 10)	
		bc = (r[7].to_f/avg_strike_rate).round(2)
		sc = (r[2].to_f/total_runs).round(2)
		br = (bc*sc*100).round(2)

		Inning.create( :match_id => match_id, :team => batting_team, :player_name => r[0], :status => r[1], :runs => r[2].to_i, :minutes => r[3].to_i, :balls => r[4].to_i, :fours => r[5].to_i, :sixes => r[6].to_i, :strike_rate => r[7].to_f, :bc => bc, :sc => sc, :br => br )
	end

	# updating total stats
	total = Inning.where(:match_id => match_id).last
	total.update_attributes( :minutes => total_minutes, :balls => total_balls, :fours => total_fours, :sixes => total_sixes, :strike_rate => avg_strike_rate, :bc => 1.0, :sc => 1.0, :br => 100.0 )

end