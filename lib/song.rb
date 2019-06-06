class Song
  attr_accessor :name, :artist, :song, :genre
  @@all = []

  def initialize(name = nil, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create(name)
    song = new(name)
    song.save
    song
  end

  def self.destroy_all
    @@all.clear
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end


  def genre=(genre)
      @genre = genre
    if genre.songs.include?(self)
      return genre.songs
    else
      genre.songs << self
    end
  end

  def self.find_by_name(name)
    @@all.find{|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    if self.find_by_name(name) == nil
      self.create(name)
    else
      return self.find_by_name(name)
    end
  end

  def self.new_from_filename(filename)
    file = filename.split(" - ")
    artist_name = file[0]
    song_name = file[1]
    genre_name = file[2].sub(/(.mp3)/, '')
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    new_song = Song.new(song_name, artist, genre)
    # binding.pry
  end

  def self.create_from_filename(filename)
    new_from_filename(filename).save
  end

end
