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

def movie_rt_query(movie)
  query = "http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=#{settings.token}&q=#{URI::encode(movie)}"
  result = JSON.parse(Net::HTTP.get(URI(query)), symbolize_names:true)[:movies][0]
  result
  # handle when nothing is returned from api
end

def reviews_rt_query(id)
  uri = "http://api.rottentomatoes.com/api/public/v1.0/movies/#{id}/reviews.json?review_type=top_critic&page_limit=50&page=1&apikey=#{settings.token}"
  reviews = JSON.parse(Net::HTTP.get(URI(uri)), symbolize_names:true)[:reviews]
end

def fix_poster(link)
  "#{link[0..-8]}det.jpg"
end

def process_reviews(reviews, opinion)
  reviews.each do |review|
    critic = Critic.find_by(name: review[:critic])
    if opinion == review[:freshness] # share same opinion/agree
      if critic
        critic.update(agree: critic.agree+1)
      else
        Critic.create({ name: review[:critic], publication: review[:publication], agree: 1 })
      end
    else # disagree
      if critic
        critic.update(agree: critic.disagree+1)
      else
        Critic.create({ name: review[:critic], publication: review[:publication], disagree: 1 })
      end
    end
  end
end

def imdb_link(rt_movie)
  "http://www.imdb.com/title/tt#{rt_movie[:alternate_ids][:imdb]}"
end


get '/' do
  @show = params[:show]
  if @show == "all"
    @critics = Critic.all.order('agree DESC')
  else
    @critics = Critic.all.order('agree DESC').limit(5)
  end
  erb :home
end

get '/rate' do
  @movie = movie_rt_query(params[:movie])
  redirect '/' unless @movie
  @poster_link = fix_poster(@movie[:posters][:detailed])

  erb :rate
end

post '/rate' do
  @opinion = params[:opinion]
  @reviews = reviews_rt_query(params[:movie_id])
  process_reviews(@reviews, @opinion)
  redirect '/'
end

post '/reset' do
  Critic.destroy_all if params[:reset] == "true"
  redirect '/'
end
