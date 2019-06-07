class Artist 
  extend Concerns::Findable

  attr_accessor :name, :genre
  
  @@all = []
  
  def initialize(name)
    @name = name
    @@all << self
    @songs =[]
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
    if song.artist == nil
      song.artist=(self)
      self.songs.find{|s| s == song} ? song : self.songs << song
    elsif song.artist == self 
      self.songs.find{|s| s == song} ? song : self.songs << song
      #binding.pry
    end 
  end   
  
  def genres 
    #binding.pry
    self.songs.collect {|song| song.genre}.uniq
  end  
  
end 