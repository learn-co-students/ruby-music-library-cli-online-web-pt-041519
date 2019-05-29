require_relative '../config/environment'
require 'pry'
class Artist
  extend Concerns::Findable
  extend Concerns::Memorable

  attr_accessor :name
  attr_reader :songs, :genre

  @@all = []

  # Initialize with name
  def initialize(name)
    @name = name    
    @songs = []
  end

  # # Read @@all array
  def self.all
    @@all
  end

  # # Save instance of self to @@all array
  def save
    @@all << self
  end

  # Add song to artist
  def add_song(song)
    # Add song to @songs if it doesn't already exist
    @songs << song if !@songs.include?(song)
    # Add artist if not already assigned
    song.artist = self if song.artist ==nil
    save
  end

  # Return array of all artist's songs
  def songs
    @songs
  end

  # Return array of all artist's song genres
  def genres
    songs.collect { |song| song.genre }.uniq
  end

end