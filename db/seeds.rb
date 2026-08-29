# frozen_string_literal: true

ContentList.destroy_all
Episode.destroy_all
Season.destroy_all
TvShow.destroy_all
Movie.destroy_all
List.destroy_all

lists = [
  List.create!(name: "Watch Later"),
  List.create!(name: "Favorites"),
  List.create!(name: "Weekend Picks"),
  List.create!(name: "Classics"),
  List.create!(name: "Foreign Films"),
  List.create!(name: "TV Marathon")
]

movies = [
  [ "Parasite", "기생충", 2019 ],
  [ "Spirited Away", "千と千尋の神隠し", 2001 ],
  [ "The Lives of Others", "Das Leben der Anderen", 2006 ],
  [ "Pan's Labyrinth", "El laberinto del fauno", 2006 ],
  [ "Amélie", "Le Fabuleux Destin d'Amélie Poulain", 2001 ],
  [ "Oldboy", "올드보이", 2003 ],
  [ "Roma", "Roma", 2018 ],
  [ "Run Lola Run", "Lola rennt", 1998 ],
  [ "The Hunt", "Jagten", 2012 ],
  [ "Train to Busan", "부산행", 2016 ],
  [ "The Handmaiden", "아가씨", 2016 ],
  [ "Another Round", "Druk", 2020 ],
  [ "The Worst Person in the World", "Verdens verste menneske", 2021 ],
  [ "Decision to Leave", "헤어질 결심", 2022 ],
  [ "Memories of Murder", "살인의 추억", 2003 ],
  [ "Shoplifters", "万引き家族", 2018 ],
  [ "The Square", "The Square", 2017 ],
  [ "A Separation", "جدایی نادر از سیمین", 2011 ],
  [ "The Secret in Their Eyes", "El secreto de sus ojos", 2009 ],
  [ "The Intouchables", "Intouchables", 2011 ]
].map do |title, original_title, year|
  Movie.create!(
    title: title,
    original_title: original_title,
    year: year
  )
end

tv_shows = [
  [ "Dark", "Dark", 2017 ],
  [ "Money Heist", "La casa de papel", 2017 ],
  [ "Squid Game", "오징어 게임", 2021 ],
  [ "Lupin", "Lupin", 2021 ],
  [ "Babylon Berlin", "Babylon Berlin", 2017 ],
  [ "The Bridge", "Bron/Broen", 2011 ],
  [ "Alice in Borderland", "今際の国のアリス", 2020 ],
  [ "Fauda", "פאודה", 2015 ],
  [ "The Bureau", "Le Bureau des Légendes", 2015 ],
  [ "Gomorrah", "Gomorra - La serie", 2014 ],
  [ "Kingdom", "킹덤", 2019 ],
  [ "Borgen", "Borgen", 2010 ],
  [ "Occupied", "Okkupert", 2015 ],
  [ "Trapped", "Ófærð", 2015 ],
  [ "The Chestnut Man", "Kastanjemanden", 2021 ],
  [ "Call My Agent!", "Dix pour cent", 2015 ],
  [ "The Killing", "Forbrydelsen", 2007 ],
  [ "Pachinko", "파친코", 2022 ],
  [ "My Brilliant Friend", "L'amica geniale", 2018 ],
  [ "Giri / Haji", "義理/恥", 2019 ]
].map do |title, original_title, year|
  TvShow.create!(
    title: title,
    original_title: original_title,
    year: year
  )
end

season_titles = [
  [ "Secrets", "Secrets" ],
  [ "The Beginning", "Der Anfang" ],
  [ "New Worlds", "Nuevos mundos" ],
  [ "The Reckoning", "Le jugement" ],
  [ "The Fall", "Der Fall" ],
  [ "The Return", "Retour" ],
  [ "Origins", "기원" ],
  [ "Aftermath", "Efterspel" ],
  [ "The Crossing", "La traversée" ],
  [ "The Unknown", "Das Unbekannte" ],
  [ "Darkness", "어둠" ],
  [ "The Divide", "La división" ],
  [ "The Resistance", "Motståndet" ],
  [ "The Investigation", "Efterforskningen" ],
  [ "The Family", "Familien" ],
  [ "The Operation", "L'opération" ],
  [ "The Game", "게임" ],
  [ "The Journey", "Il viaggio" ],
  [ "The Truth", "La verdad" ],
  [ "The End", "끝" ]
]

seasons = tv_shows.map.with_index do |tv_show, i|
  title, original_title = season_titles[i]

  Season.create!(
    title: title,
    original_title: original_title,
    year: tv_show.year,
    position: 1,
    tv_show: tv_show
  )
end

episode_titles = [
  [ "Secrets", "Secrets" ],
  [ "The Beginning", "The Beginning" ],
  [ "First Contact", "First Contact" ],
  [ "The Meeting", "The Meeting" ],
  [ "The Escape", "The Escape" ],
  [ "Aftermath", "Aftermath" ],
  [ "Homecoming", "Homecoming" ],
  [ "The Truth", "The Truth" ],
  [ "Crossroads", "Crossroads" ],
  [ "The Last Day", "Der letzte Tag" ],
  [ "The Journey", "La traversée" ],
  [ "The Choice", "Die Entscheidung" ],
  [ "Reunion", "재회" ],
  [ "The Visitor", "L'invitée" ],
  [ "Broken", "Brisé" ],
  [ "The Signal", "Der Ruf" ],
  [ "The Fall", "La chute" ],
  [ "Reckoning", "계산" ],
  [ "The Return", "La vuelta" ],
  [ "Finale", "Finale" ]
]

episodes = seasons.map.with_index do |season, i|
  title, original_title = episode_titles[i]

  Episode.create!(
    title: title,
    original_title: original_title,
    year: season.year,
    position: 1,
    season: season
  )
end

contents = movies + tv_shows + seasons + episodes

contents.each_with_index do |content, i|
  ContentList.create!(
    list: lists[i % lists.length],
    content: content,
    position: (i / lists.length) + 1
  )
end
