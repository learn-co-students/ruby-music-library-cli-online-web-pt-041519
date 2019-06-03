require_relative '../config/environment'
require 'pry'
class Song
  extend Concerns::Findable
  extend Concerns::Memorable
    include Concerns::MemorableInstance

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  # Initialize with name
  def initialize(name, artist = nil, genre = nil)
    @name = name 
    # Set artist and save if object exists
    self.artist = artist if artist != nil
    # Set genre and save if object exists
    self.genre = genre if genre != nil
  end

  # Get artist object, save song to artist @@all
  def artist=(artist)
    # Save artist to song
    @artist = artist
    # Save song to artist songs array 
    artist.add_song(self)
  end

  # Get genre object, save song to genre @@all
  def genre=(genre)
    # Save genre to song
    @genre = genre
    # Save song to genre songs array 
    genre.add_song(self)
  end

  # Read @@all array
  def self.all
    @@all
  end

  # Custom class constructor with name, artist, genre that saves instance to @@all
  def self.create(name, artist = nil, genre = nil)
    self.new(name, artist, genre).tap(&:save)
  end

  # Parse filename, create new song, associate song with artist and genre, and return new song instance
  def self.new_from_filename(filename)

    # Separate filename into song name and artist name
    artist_name, song_name, genre_name = filename.delete_suffix(".mp3").split(" - ")

    # Find or create artist object
    artist = Artist.find_or_create_by_name(artist_name)

    # Find or create genre object
    genre = Genre.find_or_create_by_name(genre_name)

    # Create new song instance with artist and genre objects
    song = self.new(song_name, artist, genre)

    # Return song object
    return song
  end

  # Create new song from filename, save to @@all, and return new song instance
  def self.create_from_filename(filename)
    self.new_from_filename(filename).tap(&:save)
  end

end