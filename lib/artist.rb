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

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    Artist.new(name).tap do |name|
      name.save
    end
  end

  def songs
    @songs
  end

  def genres #returns a collection of genres for all of the artist's songs
    songs.collect { |song| song.genre}.uniq
  end

# Add song to artist
  def add_song(song_title)
    #adds the song to the current artist's 'songs' collection = @songs
     #does not add the song to the current artist's collection of songs if it already exists therein
     songs << song_title if !songs.detect{|song| song == song_title}


    #assigns the current artist to the song's 'artist' property (song belongs to artist)
     #does not assign the artist if the song already has an artist

    song_title.artist = self if song_title.artist == nil
  end

end