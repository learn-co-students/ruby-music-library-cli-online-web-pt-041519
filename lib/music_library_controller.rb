require "pry"

class MusicLibraryController
attr_accessor :path

def initialize(path = "./db/mp3s")
  @path = path
  music_importer = MusicImporter.new(path)
  music_importer.import
end

def call
  input = ""
  until input == "exit"
  puts "Welcome to your music library!"
  puts "To list all of your songs, enter 'list songs'."
  puts "To list all of the artists in your library, enter 'list artists'."
  puts "To list all of the genres in your library, enter 'list genres'."
  puts "To list all of the songs by a particular artist, enter 'list artist'."
  puts "To list all of the songs of a particular genre, enter 'list genre'."
  puts "To play a song, enter 'play song'."
  puts "To quit, type 'exit'."
  puts "What would you like to do?"
  input = gets.strip

  case input
  when "list songs"
    list_songs
  when "list artists"
    list_artists
  when "list genres"
    list_genres
  when "list artist"
    list_songs_by_artist
  when "list genre"
    list_songs_by_genre
  when "play song"
    play_song
  end
end
end

def list_songs
  Song.all.sort{|song_a, song_b| song_a.name <=> song_b.name}.each_with_index do |song, i|
    puts "#{i + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
  end
end

def list_artists
  Artist.all.sort{|artist_a, artist_b| artist_a.name <=> artist_b.name}.each_with_index do |artist, i|
    puts "#{i +1}. #{artist.name}"
  end
end

def list_genres
  Genre.all.sort{|genre_a, genre_b| genre_a.name <=> genre_b.name}.each_with_index do |genre, i|
    puts "#{i + 1}. #{genre.name}"
  end
end

def list_songs_by_artist
  puts "Please enter the name of an artist:"
  input = gets.strip
  Artist.all.each do |artist|
    if artist.name == input
      artist.songs.sort{|song_a, song_b| song_a.name <=> song_b.name}.each_with_index do |song, i|
        puts "#{i + 1}. #{song.name} - #{song.genre.name}"
    end
  end
end
end

def list_songs_by_genre
  puts "Please enter the name of a genre:"
  input = gets.strip
  Genre.all.each do |genre|
    if genre.name == input
      genre.songs.sort{|song_a, song_b| song_a.name <=> song_b.name}.each_with_index do |song, i|
        puts "#{i +1}. #{song.artist.name} - #{song.name}"
      end
    end
  end
end

def play_song
  puts "Which song number would you like to play?"
  input = gets.strip.to_i
  if (1..Song.all.length).include?(input)
    Song.all.sort{|song_a, song_b| song_a.name <=> song_b.name}.each_with_index do |song, i|
      if i + 1 == input
        puts "Playing #{song.name} by #{song.artist.name}"
      end
    end
  end
end

end
