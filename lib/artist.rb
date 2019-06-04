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
    @songs << song unless @songs.include?(song)
    song.artist = self unless song.artist
  end

  def genres
    songs.map(&:genre).uniq
  end

end