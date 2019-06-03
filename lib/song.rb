require_relative './concerns/findable'


class Song
extend Concerns::Findable  
  attr_accessor :name, :artist, :genre
  
  
  @@all = []
  
  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end
  
  def self.all
    @@all
  end
  
  def save
    @@all << self
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def self.create(name)
    song = self.new(name)
    song.save
    song
  end
  
  def artist=(artist)
     @artist = artist
     artist.add_song(self)
   end
  
 def genre=(genre)
    @genre = genre
    genre.add_song(self)
 end
# song = Song.new_from_filename("Thundercat - For Love I Come - dance.mp3")
# initialize(name, artist=nil, genre=nil)
  def self.new_from_filename(file)
    stuff = file.sub(".mp3", "").split(" - ")
    # stuff is actually ["Thundercat", "For..."]
    artist = Artist.find_or_create_by_name(stuff[0])
    genre = Genre.find_or_create_by_name(stuff[2])
    self.new(stuff[1], artist, genre)
  end

  def self.create_from_filename(file)
      song = self.new_from_filename(file)
      song.save
      song
  end
end