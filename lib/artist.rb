require 'pry'
require_relative './concerns/findable.rb'
class Artist
 extend Concerns::Findable

 attr_accessor :name, :songs, :genres

 @@all = []

 def initialize(name)
   @name = name
   #@@all << self
   @songs = []
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
   self.new(name).tap do |artist|
     artist.save
   end

   # Make a new Artist object
   # Save that object
   # Return that object

   #new_artist = self.new(name)
   #new_artist.save
   #return new_artist
 end

 def songs
   @songs
 end

 def add_song(song)
   song.artist = self unless song.artist == self
   songs << song unless @songs.include?(song)
   #add song to @songs UNLESS @songs includes song
 end

 def genres
   self.songs.collect{|s| s.genre}.uniq
 end

end