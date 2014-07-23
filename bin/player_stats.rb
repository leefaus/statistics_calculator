class PlayerStats
	ATTRIBUTES = [ :player_id, :year_id, :league, :team_id, :games, :at_bats, :runs, 
		:hits, :doubles, :triples, :home_run, :rbi, :stolen_bases, :caught_stealing]

	ATTRIBUTES.each do |attr|
		attr_accessor attr
	end

	def initialize player_row
		ATTRIBUTES.each_with_index do |attr, index|
			instance_variable_set("@#{attr}", player_row[index])
		end
	end
end