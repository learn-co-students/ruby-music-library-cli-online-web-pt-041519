require "pry"
require_relative './concerns/findable.rb'

class Artist
   extend Concerns::Findable

   attr_accessor :name, :song
   attr_reader :genres

   @@all = []

   def initialize(name)
      @name = name
      @songs = []
   end

   def songs
      @songs
   end

   def genres 
      songs.collect {|song| song.genre}.uniq
      # binding.pry
   end

   def add_song(song) 
      song.artist = self if !song.artist
      @songs << song if !songs.include?(song) 
   end

   def save
      @@all << self
   end

   def self.all
      @@all
      # binding.pry
   end

   def self.destroy_all
      @@all.clear
   end

   def self.create(artist_name)
      self.new(artist_name).tap(&:save)
      # artist = Artist.new(artist_name)
      # artist.save
      # artist
      # binding.pry
   end
end