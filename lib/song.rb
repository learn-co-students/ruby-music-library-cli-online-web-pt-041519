require 'pry'

class Song
 extend Concerns::Findable

 attr_accessor :name, :artist, :genre

 @@all = []

 def initialize(name, artist = nil, genre = nil)
   @name = name
   #@@all << self
   self.artist= artist if artist != nil
   self.genre= genre if genre != nil
 end

 def name
   @name
 end

 def self.all
   @@all
 end

 def self.destroy_all
   @@all.clear
 end

 def save
   self.class.all << self
 end

 def self.create(name)
   self.new(name).tap do|song|
   song.save
   end
 end

 def artist=(artist)
   @artist = artist #defining the instance variable @artist
   artist.add_song(self) #invoking the add_song method on the defined artist
 end

 def genre=(genre)
   @genre = genre
   genre.songs << self unless genre.songs.include?(self)
 end
 
 def self.new_from_filename(filename)
    array = filename.split(" - ")

    song_name = array[1]
    artist_name = array[0]
    genre_name = array[2].split(".mp3").join

    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    self.new(song_name, artist, genre)
  end
  
  def self.create_from_filename(filename)
    self.new_from_filename(filename).save
  end

end