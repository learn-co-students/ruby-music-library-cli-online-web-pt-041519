require_relative '../config/environment'
require 'pry'
class Genre
  extend Concerns::Findable
  extend Concerns::Memorable
  include Concerns::MemorableInstance

  attr_accessor :name
  attr_reader :songs

  @@all = []

  # Initialize with name
  def initialize(name)
    @name = name
    @songs = []    
  end

  # Read @@all array
  def self.all
    @@all
  end

  # Add song to genre
  def add_song(song)
    # Add song to @songs if it doesn't already exist
    @songs << song if !@songs.include?(song)
    # Add genre if not already assigned
    song.genre = self if song.genre ==nil
    save
  end

  # Return collection of all artists; go through songs to get artists
  def artists
    @songs.collect { |song| song.artist }.uniq
  end

end