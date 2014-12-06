require 'dotenv'
require 'pg'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'json'
require 'net/http'
require 'open-uri'
require 'pry'

require_relative './models/critic'

Dotenv.load

configure do
  set :token, ENV['TOKEN']
end

def movie_title(movie)
  query = "http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=#{settings.token}&q=#{URI::encode(movie)}"
  movie_result = JSON.parse(Net::HTTP.get(URI(query)), symbolize_names:true)[:movies][0]
  movie_result[:title]
  # inspect the links that api call returns for something interesting
  #handle nothing returned from api somehow
end


get '/' do
  @critics = Critic.all
  erb :home
end

get '/rate' do

  @movie = movie_title(params[:movie])
  # get movie poster?

  # upsert all the critics who reviewed the movie

  # http://guides.rubyonrails.org/active_record_querying.html#scopes

  # store movie name into a table??

  erb :rate # update critics based on clicked "rotten" or "fresh"
end


# reviews = JSON.parse(Net::HTTP.get(URI("http://api.rottentomatoes.com/api/public/v1.0/movies/#{movie[:id]}/reviews.json?review_type=top_critic&page_limit=50&page=1&apikey=#{api_key}")), symbolize_names:true)[:reviews]
# puts "Was \"#{movie[:title]}\" rotten or fresh?"
# freshness = gets.chomp.downcase
# reviews.each do |review|
#   if !critic_profiles.has_key?("#{review[:critic]}, #{review[:publication]}")
#     critic_profiles["#{review[:critic]}, #{review[:publication]}"] = { agree: 0, disagree: 0}
#   end
#
#   if review[:freshness] == freshness
#     critic_profiles["#{review[:critic]}, #{review[:publication]}"][:agree] += 1
#   else
#     critic_profiles["#{review[:critic]}, #{review[:publication]}"][:disagree] += 1
#   end
# end
