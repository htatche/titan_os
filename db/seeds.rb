ContentList.destroy_all
Episode.destroy_all
Season.destroy_all
TvShow.destroy_all
Movie.destroy_all
List.destroy_all

# Movies

movies = [
  Movie.create!(
    title: "The Last Horizon",
    original_title: "The Last Horizon",
    year: 2024
  ),

  Movie.create!(
    title: "Neon City",
    original_title: "Neon City",
    year: 2021
  ),

  Movie.create!(
    title: "Silent Orbit",
    original_title: "Silent Orbit",
    year: 2019
  ),

  Movie.create!(
    title: "Winter Signal",
    original_title: "Winter Signal",
    year: 2022
  ),

  Movie.create!(
    title: "Red Valley",
    original_title: "Red Valley",
    year: 2020
  )
]

# TV Shows

tv_shows = [
  TvShow.create!(
    title: "Northern Lights",
    original_title: "Northern Lights",
    year: 2023
  ),

  TvShow.create!(
    title: "The Long Night",
    original_title: "The Long Night",
    year: 2021
  ),

  TvShow.create!(
    title: "Deep Space",
    original_title: "Deep Space",
    year: 2020
  ),

  TvShow.create!(
    title: "City Lines",
    original_title: "City Lines",
    year: 2022
  ),

  TvShow.create!(
    title: "Broken Signals",
    original_title: "Broken Signals",
    year: 2024
  )
]

# Seasons
#
# position = canonical season number
# title = actual season title

seasons = [
  Season.create!(
    tv_show: tv_shows[0],
    title: "The Beginning",
    original_title: "The Beginning",
    year: 2023,
    position: 1
  ),

  Season.create!(
    tv_show: tv_shows[0],
    title: "Into the Dark",
    original_title: "Into the Dark",
    year: 2024,
    position: 2
  ),

  Season.create!(
    tv_show: tv_shows[1],
    title: "After Sunset",
    original_title: "After Sunset",
    year: 2021,
    position: 1
  ),

  Season.create!(
    tv_show: tv_shows[2],
    title: "Beyond Earth",
    original_title: "Beyond Earth",
    year: 2020,
    position: 1
  ),

  Season.create!(
    tv_show: tv_shows[3],
    title: "Crossroads",
    original_title: "Crossroads",
    year: 2022,
    position: 1
  )
]

# Episodes
#
# position = canonical episode number
# title = actual episode title

episodes = [
  Episode.create!(
    season: seasons[0],
    title: "First Light",
    original_title: "First Light",
    year: 2023,
    position: 1
  ),

  Episode.create!(
    season: seasons[0],
    title: "The Signal",
    original_title: "The Signal",
    year: 2023,
    position: 2
  ),

  Episode.create!(
    season: seasons[0],
    title: "Crossing",
    original_title: "Crossing",
    year: 2023,
    position: 3
  ),

  Episode.create!(
    season: seasons[1],
    title: "The Return",
    original_title: "The Return",
    year: 2024,
    position: 1
  ),

  Episode.create!(
    season: seasons[1],
    title: "Afterlight",
    original_title: "Afterlight",
    year: 2024,
    position: 2
  ),

  Episode.create!(
    season: seasons[2],
    title: "Darkness Falls",
    original_title: "Darkness Falls",
    year: 2021,
    position: 1
  ),

  Episode.create!(
    season: seasons[2],
    title: "The Road Home",
    original_title: "The Road Home",
    year: 2021,
    position: 2
  ),

  Episode.create!(
    season: seasons[3],
    title: "Launch Day",
    original_title: "Launch Day",
    year: 2020,
    position: 1
  ),

  Episode.create!(
    season: seasons[3],
    title: "Beyond the Moon",
    original_title: "Beyond the Moon",
    year: 2020,
    position: 2
  ),

  Episode.create!(
    season: seasons[4],
    title: "First Contact",
    original_title: "First Contact",
    year: 2022,
    position: 1
  )
]

# Lists

lists = [
  List.create!(name: "Weekend Watch"),
  List.create!(name: "Sci-Fi Mix"),
  List.create!(name: "Favorites")
]

# Weekend Watch — deliberately mixed

[
  movies[0],
  tv_shows[0],
  episodes[0],
  movies[1],
  seasons[0],
  episodes[3],
  tv_shows[1],
  movies[4],
  episodes[5],
  seasons[2]
].each_with_index do |content, index|
  ContentList.create!(
    list: lists[0],
    content: content,
    position: index + 1
  )
end

# Sci-Fi Mix

[
  tv_shows[2],
  movies[2],
  episodes[7],
  seasons[3],
  movies[0],
  episodes[8],
  tv_shows[0],
  seasons[1],
  episodes[4],
  movies[3]
].each_with_index do |content, index|
  ContentList.create!(
    list: lists[1],
    content: content,
    position: index + 1
  )
end

# Favorites

[
  episodes[1],
  movies[4],
  tv_shows[1],
  seasons[2],
  episodes[5],
  movies[1],
  tv_shows[3],
  episodes[9],
  seasons[4],
  movies[2]
].each_with_index do |content, index|
  ContentList.create!(
    list: lists[2],
    content: content,
    position: index + 1
  )
end

puts "Database seeded successfully."
puts "Movies: #{Movie.count}"
puts "TV Shows: #{TvShow.count}"
puts "Seasons: #{Season.count}"
puts "Episodes: #{Episode.count}"
puts "Lists: #{List.count}"
puts "List items: #{ContentList.count}"
