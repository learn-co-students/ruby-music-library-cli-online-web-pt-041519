require_relative "./concerns/findable.rb"

class Genre 
  
   extend Concerns::Findable 
  
   attr_accessor :name, :songs, :artist 
  
   @@all = []

   def initialize(name)
     @name = name 
     @songs = []
     @genres = []
     @@all << self 
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
     created_genre = Genre.new(name)
     created_genre.save 
     return created_genre
   end 
   
   def add_song(song)
     unless @songs.include?(song) 
       @songs << song 
     end 
     song.genre ||= self 
   end 
   
   def artists 
     @songs.collect {|song| song.artist}.uniq 
   end 
   
end 