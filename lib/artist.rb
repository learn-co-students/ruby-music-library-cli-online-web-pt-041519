require 'pry'

class Artist

  extend Concerns::Findable

  @@all = []

  attr_accessor :name
  attr_reader :songs

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    @@all << self
  end

  def self.create(artist_name)
    self.new(artist_name).tap(&:save)
  end

  def add_song(song)
    @songs << song if !@songs.include?(song)
    song.artist = self if !song.artist
  end

  ## return a collection of genres for all of the artist's songs, no dupluicate genres
  def genres
    songs.map {|song| song.genre}.uniq
  end

end