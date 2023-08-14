# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb
# db/seeds.rb
require 'open-uri'
require 'json'

# Function to fetch top-rated movies from the provided API
def fetch_top_rated_movies
  url = "http://tmdb.lewagon.com/movie/top_rated"
  movies_serialized = URI.open(url).read
  movies = JSON.parse(movies_serialized)
  movies['results']
end

# Cleaning database...
puts "Cleaning database..."
Bookmark.destroy_all # destroy bookmarks first because they reference movies and lists
List.destroy_all     # then destroy lists
Movie.destroy_all    # and finally destroy movies

# Seeding movies...
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

# Creating lists
puts "Creating lists..."
top_10_movies = List.create(name: "Top 10 Movies")
must_watch_movies = List.create(name: "Must Watch Movies")

# Associating the first 10 movies to the Top 10 Movies list
puts "Associating movies to Top 10 Movies list..."
Movie.first(10).each do |movie|
  Bookmark.create(list: top_10_movies, movie: movie, comment: "Amazing movie!")
end

# Associating the next 10 movies to the Must Watch Movies list
puts "Associating movies to Must Watch Movies list..."
Movie.offset(10).limit(10).each do |movie|
  Bookmark.create(list: must_watch_movies, movie: movie, comment: "Must watch!")
end

puts "Done seeding!"
