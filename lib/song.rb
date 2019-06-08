class Song 
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist != nil 
    self.genre = genre if genre != nil
  end 
  
  def self.all
    @@all 
  end 
  
  def save 
    @@all << self 
  end 
  
  def self.destroy_all
    self.all.clear
  end 
  
  def self.create(name)
    Song.new(name).tap {|s| s.save}
  end 
  
  def artist=(artist)
    @artist = artist 
    artist.add_song(self)
  end 
  
  def genre=(genre)
    @genre = genre 
    genre.songs << self unless genre.songs.include?(self)
  end 
  
  def self.find_by_name(name)
    self.all.find {|song| song.name == name}
  end 
  
  def self.find_or_create_by_name(name)
    artist = self.find_by_name(name)
    if artist == nil 
      self.create(name)
    else 
      artist 
    end 
  end 
  
  # def self.new_from_filename(filename)
    
  # end 
  
end 