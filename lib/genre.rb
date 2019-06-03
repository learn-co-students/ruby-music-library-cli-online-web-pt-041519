require 'pry'

class Genre

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

  def self.create(genre_type)
    self.new(genre_type).tap(&:save)
  end

  def artists
    songs.map{|song| song.artist}.uniq
  end

end