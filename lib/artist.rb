require_relative "./concerns/findable.rb"

class Artist 

   extend Concerns::Findable 

   attr_accessor :name, :songs
  
   @@all = []

   def initialize(name)
     @name = name
     @songs = []
     @@all << self 
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
     created_artist = Artist.new(name)
     created_artist.save 
     return created_artist 
   end 
   
   def add_song(song)
     unless @songs.include?(song)
       @songs << song 
     end 
     song.artist ||= self 
   end 
   
   def genres 
     @songs.collect {|song| song.genre}.uniq
   end 
   
end 