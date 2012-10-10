class Inning < ActiveRecord::Base

	def self.last_inning
		match_id = Inning.last.match_id
		Inning.where( :match_id => match_id )
	end

end
