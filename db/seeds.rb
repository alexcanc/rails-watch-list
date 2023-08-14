# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb
require 'open-uri'
require 'json'

def fetch_top_rated_movies
  url = "http://tmdb.lewagon.com/movie/top_rated"
  movies_serialized = URI.open(url).read
  movies = JSON.parse(movies_serialized)
  movies['results']
end

puts "Cleaning database..."
Movie.destroy_all

puts "Seeding movies..."
movies = fetch_top_rated_movies
movies.each do |movie|
  Movie.create!(
    title: movie['title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/original#{movie['poster_path']}",
    rating: movie['vote_average']
  )
  puts "Created #{movie['title']}"
end
