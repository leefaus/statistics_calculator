require 'rubygems'
require 'csv'
require_relative 'player'
require_relative 'player_stats'

class StatBuilder

	def initialize
		@player_listings = Hash.new
		CSV.foreach("resources/Master-small.csv") do |row|
			@player_listings.merge! row[0] => Player.new(row)
		end
	end

	def most_improved_batting_average year 
		players = Hash.new
		most_improved_players = Hash.new
		most_improved = 0.0
		next_year = year.to_i + 1
		CSV.foreach("resources/Batting-07-12.csv") do |row|
			player_stats = PlayerStats.new(row)
			if (player_stats.at_bats.to_i >= 200) && ((player_stats.year_id == year) || (player_stats.year_id == next_year.to_s)) 
				if players[player_stats.player_id].nil?
					players.merge! player_stats.player_id => {player_stats.year_id => calc_batting_average(player_stats.hits, player_stats.at_bats)}
				else 
					players[player_stats.player_id].merge! player_stats.year_id => calc_batting_average(player_stats.hits, player_stats.at_bats)
				end
			end
		end
		players.each do |player_id,stats|
			if stats.length == 2
				diff = stats[next_year.to_s] - stats[year]
				if diff > most_improved
					most_improved = diff
					most_improved_players = { player_id => diff }
				elsif diff == most_improved
					most_improved_players.merge! player_id => diff
				end
			end
		end
		most_improved_players.each do |key,value|
			puts "#{@player_listings[key].first_name} #{@player_listings[key].last_name} = #{value} "
			return @player_listings[key].first_name + " " + @player_listings[key].last_name
		end
	end

	def slugging_percentage year, team
		players = Hash.new
		CSV.foreach("resources/Batting-07-12.csv") do |row|
			player_stats = PlayerStats.new(row)
			if ((player_stats.year_id == year) && (team == player_stats.team_id))
				slug_percent = calc_slugging_percentage(player_stats)
				puts "#{@player_listings[player_stats.player_id].first_name} #{@player_listings[player_stats.player_id].last_name} = #{slug_percent}"
				players.merge! "#{@player_listings[player_stats.player_id].first_name} #{@player_listings[player_stats.player_id].last_name}" => "#{slug_percent}"
			end
		end
		return players
	end

	def triple_crown_winner year, league
		#highest batting avg AND most home runs AND most RBIs (Minimum of 400 at-bats)
		triple_crown = Hash.new
		#find highest batting avg in league
		highest_batting_avg = 0.0
		#find most home runs in league
		most_home_runs = 0
		#find most RBIs in league
		most_rbis = 0

		CSV.foreach("resources/Batting-07-12.csv") do |row|
			player_stats = PlayerStats.new(row)
			if ((player_stats.at_bats.to_i >= 400) && (player_stats.year_id == year) && (league == player_stats.league))
				batting_avg = calc_batting_average(player_stats.hits, player_stats.at_bats)
				if batting_avg > highest_batting_avg
					triple_crown.merge! "batting_avg" => {player_stats.player_id => batting_avg}
					highest_batting_avg = batting_avg
				end
				if player_stats.home_run.to_i > most_home_runs
					triple_crown.merge! "home_runs" => {player_stats.player_id => most_home_runs}
					most_home_runs = player_stats.home_run.to_i
				end
				if player_stats.rbi.to_i > most_rbis
					triple_crown.merge! "rbis" => {player_stats.player_id => most_rbis}
					most_rbis = player_stats.rbi.to_i
				end
			end
		end
		puts "Home Run Leader = #{@player_listings[triple_crown["home_runs"].keys[0]].first_name} #{@player_listings[triple_crown["home_runs"].keys[0]].last_name}"
		puts "RBI Leader = #{@player_listings[triple_crown["rbis"].keys[0]].first_name} #{@player_listings[triple_crown["rbis"].keys[0]].last_name}"
		puts "Batting Average Leader = #{@player_listings[triple_crown["batting_avg"].keys[0]].first_name} #{@player_listings[triple_crown["batting_avg"].keys[0]].last_name}"
		if ((triple_crown["batting_avg"].keys[0] == triple_crown["home_runs"].keys[0]) && (triple_crown["home_runs"].keys[0] == triple_crown["rbis"].keys[0]))
			puts "#{@player_listings[triple_crown["batting_avg"].keys[0]].first_name} #{@player_listings[triple_crown["batting_avg"].keys[0]].last_name} is the winner!"
			return @player_listings[triple_crown["batting_avg"].keys[0]].first_name + " " + @player_listings[triple_crown["batting_avg"].keys[0]].last_name
		else
			puts "No winner found."
			return "No Winner"
		end

	end

	def calc_batting_average hits, at_bats
		hits.to_f/at_bats.to_f
	end

	def calc_slugging_percentage ps
		#((hits-doubles-triples-hr) + (2 * doubles) + (3 * triples) + (4 * hr)) / at-bats
		if ps.hits.to_i == 0 && ps.at_bats.to_i == 0
			0.0
		else
			((ps.hits.to_f - ps.doubles.to_f - ps.triples.to_f - ps.home_run.to_f) + (2 * ps.doubles.to_f) + (3 * ps.triples.to_f) + (4 * ps.home_run.to_f))/ps.at_bats.to_f
		end
	end

end
