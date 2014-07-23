require_relative '../../bin/statbuilder'

Given /I have entered (\d+) into the statbuilder/ do |n|
	statbuilder = StatBuilder.new
	@player_name = statbuilder.most_improved_batting_average n
end

Then /^the result should be (.*?)$/ do |n|
  expect(@player_name).to eq(n)
end

Given /^I have entered (\d+) and (.*) into the statbuilder$/ do |year, team|
	statbuilder = StatBuilder.new
  	@players = statbuilder.slugging_percentage year, team
end

Then /^The number of players should be (\d+)$/ do |l|
  	expect(l.to_i).to eq(@players.length)
end

And /^(.*?) slugging percentage should be (.+)$/ do |name, slugging_percentage|
	expect(@players[name]).to eq(slugging_percentage)
end

Given /^I have entered (\d+) and (.*?) for triple crown$/ do |year, league|
	statbuilder = StatBuilder.new
  	@player = statbuilder.triple_crown_winner year, league
end

Then /^The answer is (.*?)$/ do |answer|
  	expect(answer).to eq(@player)
end