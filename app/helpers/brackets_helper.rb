module BracketsHelper

	def get_team_name(bracket, association_name) 
		team = bracket.send(association_name)
		team_name = ""
		if (team.blank?)
			team_name = ""
		else
			team_name = team.name
		end
		return team_name
	end

	def get_team_info(bracket, association_name) 
		team_info = Hash.new
		team = bracket.send(association_name)
		if (team.blank?)
			team_info[:name] = ""
			team_info[:seat] = ""
			team_info[:record] = ""
		else
			team_info[:name] = team.name
			team_info[:seat] = team.seat
			team_info[:record] = team.record
		end
		return team_info
	end

	def get_green(bracket, master_bracket, col_name) 
		if (bracket.id != master_bracket.id)  # check to make sure we are not editing the master.  No need to highlight the master.
			if (bracket.send(col_name) == master_bracket.send(col_name))
				if (master_bracket.send(col_name).present?) 
					return "green"
				end
			end
		end
	end

end
