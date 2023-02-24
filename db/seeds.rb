# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "open-uri"
require "json"
require "faker"

Bookmark.delete_all
puts "deleting bookmarks"

List.delete_all
puts "deleting lists"

Movie.delete_all
puts "deleting movies"


url = "https://tmdb.lewagon.com/movie/top_rated"

movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)

movies=movies["results"]
puts movies

puts "creating movies..."
movies.each do |movie|
  new_movie = Movie.new
  puts "added new movie"
  new_movie.title = movie['original_title']
  puts "added movie title"
  new_movie.overview = movie['overview']
  puts "added movie overview"
  new_movie.poster_url = "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}"
  puts "added movie url"
  new_movie.rating = movie["vote_average"]
  puts "added movie_rating"
  new_movie.save
end
puts "finished creating movies..."

puts "creating lists..."
10.times do
  List.create(name:Faker::Ancient.hero)
end
puts "finished lists..."

puts "creating bookmarks"
100.times do
  Bookmark.create(comment:Faker::Lorem.words(number: 4), movie_id: rand(1..20), list_id: rand(1..10))
end
puts "finishied bookmarks..."

# each movie has:
# t.string "title" movie["original_title"]
# t.string "overview" movie["overview"]
# t.text "poster_url" https://image.tmdb.org/t/p/w500movie["poster_path"]
# t.decimal "rating" movie["vote_average"]
