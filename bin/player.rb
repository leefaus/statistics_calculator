class Player
	ATTRIBUTES = [:player_id, :birth_year, :first_name, :last_name]

	ATTRIBUTES.each do |attr|
		attr_accessor attr
	end

	def initialize player_row
		ATTRIBUTES.each_with_index do |attr, index|
			instance_variable_set("@#{attr}", player_row[index])
		end
	end
end