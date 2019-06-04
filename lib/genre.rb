require_relative './concerns/findable.rb'
class Genre
 attr_accessor :name, :songs, :artists
 extend Concerns::Findable

 @@all = []

 def initialize(name)
   @name = name
   #@@all << self
   @songs = []
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
   self.new(name).tap do |genre|
     genre.save
     end
   end

 def songs
   @songs
 end

 def artists
   self.songs.collect{|s| s.artist}.uniq
 end


end