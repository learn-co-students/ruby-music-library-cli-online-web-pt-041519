require 'pry'
class Song
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist != nil # if artist is not empty invoked
    self.genre = genre if genre != nil
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    # song = Song.new(name)
    # song.save
    # song
    Song.new(name).tap(&:save)
  end

  def artist=(artist) #invokes Artist#add_song to add itself
    #to the artist's collection of songs (artist has many songs)
    @artist = artist
    artist.add_song(self)
  end


  def genre=(genre)
   @genre = genre
   genre.songs << self unless genre.songs.include?(self)
 end
 #
 # def genre=(genre) #invokes Artist#add_song to add itself
 #   #to the artist's collection of songs (artist has many songs)
 #   @genre = genre
 #   genre.add_song(self)
 # end
 def self.find_by_name(song_name)
   all.detect {|song_title| song_title.name == song_name}
 end

 def self.find_or_create_by_name(name)
  find_by_name(name) || create(name)
 end

 def self.new_from_filename(filename)
  parts = filename.split(" - ")
  artist_name, song_name, genre_name = parts[0], parts[1], parts[2].chomp(".mp3")

  artist = Artist.find_or_create_by_name(artist_name)
  genre = Genre.find_or_create_by_name(genre_name)
  song = self.new(song_name, artist, genre)
  #binding.pry
 end

 def self.create_from_filename(filename)
   self.new_from_filename(filename).save
 end

end