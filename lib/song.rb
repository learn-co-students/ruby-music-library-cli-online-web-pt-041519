require 'pry'

class Song
  extend Concerns::Findable
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

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(song)
    created_song = Song.new(song) #song is identified as variable created_song
    created_song.save #save new instance of song
    created_song #return song
  end

  def artist=(artist)
    #if no variable given for
    #assigns artist instance
    #if artist is defined, then..
    @artist == nil ? @artist = artist : @artist = @artist
      #so long as artist is not nil, add the song to the artist's collection of songs
      if self.artist != nil
        @artist.add_song(self)
      end
    @artist #return status of artist
  end

  def genre=(genre)
    @genre == nil ? @genre = genre : @genre = @genre
    if self.genre != nil
        @genre.add_song(self)
    end
    @genre
  end

  # def self.find_by_name(song_name)
  #   found_song = @@all.find { |song| song.name == song_name } #finds a song by song name, sets it as found_song
  #   found_song #returns the found song
  # end
  #
  # def self.find_or_create_by_name(song_name)
  #   if find_by_name(song_name) #if the song is found
  #       find_by_name(song_name) #returns song name
  #   else
  #     self.create(song_name) #if song is not found, creates a new song and returns it
  #   end
  # end

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

=begin code below does not work
  # def self.new_from_filename(filename)
  #   #parse the filename
  #   song_name = filename.split(" - ")[1]
  #   artist_name = filename.split(" - ")[0]
  #   genre_name = filename.split(" - ")[2].chomp(".mp3")
  #   #create song and assign artist and genre attribute, & create connections
  #   #prevent the creation of duplicate objects: songs, artists, genres
  #   #song = self.create(song_name)
  #   song = self.find_or_create_by_name(song_name)
  #   #song.artist = Artist.create(artist_name)
  #   song.artist = Artist.find_or_create_by_name(artist_name)
  #   #song.genre = Genre.create(genre_name)
  #   song.genre = Genre.find_or_create_by_name(genre_name)
  #   song
  # end
=end

  def self.create_from_filename(filename)
    new_from_filename(filename).tap{ |s| s.save }
  end
end
