# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'uri'
require 'net/http'

# nombre maximum de films à importer
max_movies_to_seed = 10

url = URI("https://tmdb.lewagon.com/movie/top_rated")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'

response = http.request(request)
movie_data = JSON.parse(response.read_body)

imported_movies_count = 0

movie_data['results'].each do |film_data|
  break if imported_movies_count >= max_movies_to_seed

  Movie.create(
    title: film_data['title'],
    poster_url: "https://image.tmdb.org/t/p/w500/#{film_data['poster_path']}",
    overview: film_data['overview'],
    rating: film_data['vote_average']
  )

  imported_movies_count += 1
end
