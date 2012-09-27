desc "Fetching Score from CricInfo.comTask description"
task :fetch_score => :environment do
	require 'mechanize'

	agent = Mechanize.new
	url = "http://www.espncricinfo.com/icc-world-twenty20-2012/engine/match/533284.html"
	agent.get(url)
	iframe_content = agent.page.iframe_with(:id => 'live_iframe').click
	title = agent.page.title
	teams = iframe_content.search('.teamText')
	team1 = teams[0].text
	team2 = teams[1].text
	status = iframe_content.search('.statusText').text
	runrates = ''
	iframe_content.search('.headRightDiv li').each do |rr|
		runrates += "<div>#{rr.content}</div>"
	end

	ScoreContent.create( :title => title, :team1 => team1, :team2 => team2, :match_status => status, :runrates => runrates.html_safe )

	# doc = Nokogiri::HTML(open(url))
	# doc_html = Nokogiri::HTML.parse(doc.frame(:name, "live_iframe").html) 

	# title = doc.at_css("title").text
	
	# teams = []
	# status = ''
	# puts "outside"
	# doc.css("iframe html body") do |body|
	# 	puts "In body"
	# 	body.at_css(".teamText").each do |team|
	# 		puts "In teams loop"
	# 		teams << team.text
	# 		puts team.text
	# 		status = doc.at_css(".statusText").text
	# 		puts status
	# 	end
	# end

	# puts doc.css("#live_iframe html").count

	# test = "ds"


end