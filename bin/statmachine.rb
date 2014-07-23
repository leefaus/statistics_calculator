#!/usr/bin/env ruby

require 'rubygems'
require 'commander/import'
require 'rainbow'

require_relative 'statbuilder'

program :version, '0.0.1'
program :description, 'A Program for Calculating MLB Statistics'
 
command :miba do |c|
  c.syntax = 'statmachine miba [options]'
  c.summary = 'Most Improved Batting Average'
  c.description = ''
  c.example 'description', ''
  c.option '--year STRING', String, 'Starting Year : year to next year. ie, 2009 would be from 2009 to 2010'
  c.action do |args, options|
    say "=> calculating #{Rainbow("Most Improved Batting Average").red.bright.underline} for year #{Rainbow(options.year).yellow.bright.underline} \n"
    sb = StatBuilder.new
    sb.most_improved_batting_average options.year
  end
end

command :sp do |c|
  c.syntax = 'statmachine sp [options]'
  c.summary = 'Slugging Percentage'
  c.description = ''
  c.example 'description', ''
  c.option '--team STRING', String, 'The team to calculate for'
  c.option '--year STRING', String, 'The year to calculate for'
  c.action do |args, options|
    say "=> calculating #{Rainbow("Slugging Percentage").red.bright.underline} for team #{Rainbow(options.team).yellow.bright.underline} in year #{Rainbow(options.year).yellow.bright.underline} \n"
    sb = StatBuilder.new
    sb.slugging_percentage options.year,options.team
  end
end

command :tcw do |c|
  c.syntax = 'statmachine tcw [options]'
  c.summary = 'Triple Crown Winner'
  c.description = ''
  c.example 'description', ''
  c.option '--league String', String, 'The league to calculate for: AL or NL'
  c.option '--year String', String, 'The year to calculate for'
  c.action do |args, options|
    say "=> calculating #{Rainbow("Triple Crown Winner").red.bright.underline} for the #{Rainbow(options.league).yellow.bright.underline} in year #{Rainbow(options.year).yellow.bright.underline} \n"
    sb = StatBuilder.new
    sb.triple_crown_winner options.year,options.league
  end
end

