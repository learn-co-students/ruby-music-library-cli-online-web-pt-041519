class Artist 
  attr_accessor :name , :song , :genre
  @@all = []
  extend Concerns::Findable
  def initialize(name)
    @name = name 
    @songs = []
    
  end
  
  def self.all 
    @@all 
  end
  
  def save 
    @@all << self
  end
  
  def songs 
    @songs 
  end
  def genres 
    genre = songs.collect{|song|song.genre}
    genre.uniq
    
    end

  def add_song(song)
    if songs.include?(song) == false 
    songs << song
    if song.artist ==nil 
      song.artist = self
    end
  end
  end
    
  def self.create(artist_name)
    artist = Artist.new(artist_name)
    artist.save
    artist
  end
  
  def self.destroy_all 
    @@all.clear
  end
end