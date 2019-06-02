require "pry"

class Genre
   extend Concerns::Findable

   attr_accessor :name, :song
   @@all = []

   def initialize(name)
      @name = name
      @songs = []
   end

   def songs
      @songs
   end

   def save
      @@all << self
   end

   def artists 
      songs.collect {|song| song.artist}.uniq
      # binding.pry
   end

   def self.all
      @@all
      # binding.pry
   end

   def self.destroy_all
      @@all.clear
   end

   def self.create(name)
      self.new(name).tap(&:save)
   end
end