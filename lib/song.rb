require 'pry'

class Song

  extend Concerns::Findable

  @@all = []

  attr_accessor :name
  attr_reader :artist, :genre


  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    self.class.all << self
  end

  def self.create(song_name)
    self.new(song_name).tap(&:save)
  #   song = Song.new(song_name)
  #   song.save
  #   song
  # end
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
    ## add song to genre's collection of songs unless it already exists there
  def genre=(genre)
    @genre = genre
    genre.songs << self if !genre.songs.include?(self)
  end

    ## finds a song instance in @@all by the name property of the song
  def self.find_by_name(name)
    @@all.find{|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end

    ## use the passed in filename to initialize a song
    ## use the method in Findables
  def self.new_from_filename(file_name)
    song_name = file_name.split(" - ")[1]
    artist_name = file_name.split(" - ")[0]
    genre_type = file_name.split(" - ")[2].chomp(".mp3")
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_type)
    song = Song.new(song_name, artist, genre)
    song
  end

  def self.create_from_filename(file_name)
    @@all << self.new_from_filename(file_name)
  end
end