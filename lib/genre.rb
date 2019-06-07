class Genre 
  extend Concerns::Findable
  
  attr_accessor :name, :artist
  
  @@all = []
  
  def initialize(name)
    @name = name
    @@all << self
    @songs =[]
    #binding.pry
  end 
  
  def self.all
    @@all
  end   
  
  def save
    self.class.all << self
  end 

  def songs 
    @songs 
  end 
  
  def add_song(song)
    #binding.pry
    if song.genre == nil
      song.genre=(self)
      self.songs.find{|s| s == song} ? song : self.songs << song
    elsif song.genre == self 
      self.songs.find{|s| s == song} ? song : self.songs << song
    end 
  end    
  
  def artists
    @artists =self.songs.collect {|song|song.artist}.uniq
  end  
end 