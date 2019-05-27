require 'pry'
require_relative './concerns/findable.rb'
class Artist
  extend Concerns::Findable
  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def songs
    @songs
  end

  def genres
    self.songs.collect(&:genre).uniq
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
  end

  def self.destroy_all
    self.all.clear
  end
# refactoring with .tap as it passes self to the block and returns self.  https://apidock.com/ruby/Object/tap
# Also using the (&:symbol) to call a method on the element being passed to .tap.
# https://www.brianstorti.com/understanding-ruby-idiom-map-with-symbol/
  def self.create(artist_name)
    self.new(artist_name).tap(&:save)
    # artist = Artist.new(artist_name)
    # artist.save
    # artist
  end
end
