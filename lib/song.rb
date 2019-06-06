class Song

  attr_accessor :name, :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
       @name = name
       self.artist=(artist) unless artist == nil
       self.genre=(genre) unless genre == nil
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

  def self.create(name)
      song = new(name)
      song.save
      song
  end

  def artist=(artist)
        @artist = artist
        artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    self.genre.songs << self unless genre.songs.include?(self)
  end

  def self.find_by_name(song)
     self.all.detect do |sg|
       sg.name == song
     end
  end

  def self.find_or_create_by_name(song)
     find_by_name(song) || create(song)
  end

  def self.new_from_filename(filename)
     parts = filename.split(" - ")
     artist_name, song_name, genre_name = parts[0], parts[1], parts[2].gsub(".mp3", "")

     artist = Artist.find_or_create_by_name(artist_name)
     genre  = Genre.find_or_create_by_name(genre_name)

     new(song_name, artist, genre)
  end

  def self.create_from_filename(filename)
    new_from_filename(filename).tap{ |sg| sg.save }
  end
end
