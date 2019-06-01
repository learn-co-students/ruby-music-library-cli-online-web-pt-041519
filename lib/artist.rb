require 'pry'
require_relative './concerns/findable.rb'
require_relative './concerns/persistable.rb'


class Artist
  extend Concerns::Findable
  extend Concerns::Persistable::ClassMethods
  include Concerns::Persistable::InstanceMethods

  attr_accessor :name, :songs

  def self.all
    @@all
  end

  def initialize(name)
    @name = name
    @songs = []
  end

  def genres
    self.songs.collect(&:genre).uniq
    #can also be
    #songs.collect{|song| song.genre}.uniq
  end

  def add_song(song)
    song.artist = self if !song.artist
    @songs << song if !songs.include?(song)
  end

end
