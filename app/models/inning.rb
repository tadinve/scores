class Inning < ActiveRecord::Base

	def self.last_inning team
		match_id = Inning.last.match_id
		Inning.where( :match_id => match_id, :team => team )
	end

end
