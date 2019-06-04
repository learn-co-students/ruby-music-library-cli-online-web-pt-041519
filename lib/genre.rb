require_relative './concerns/findable.rb'
class Genre
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

  def self.create(genre_name)
    Genre.new(genre_name).tap do |genre_name|
      genre_name.save
    end
  end

  def add_song(song_title)
    #adds the song to the current artist's 'songs' collection = @songs
     #does not add the song to the current artist's collection of songs if it already exists therein
    songs << song_title if !songs.detect{|song| song == song_title}

    #assigns the current artist to the song's 'artist' property (song belongs to artist)
     #does not assign the artist if the song already has an artist

    song_title.genre = self if song_title.genre == nil
  end

  def artists
    songs.collect{ |song| song.artist }.uniq
  end
end