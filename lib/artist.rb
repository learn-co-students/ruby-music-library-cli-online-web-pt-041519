class Artist
  extend Concerns::Findable

  attr_accessor :name

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

  def self.create(artist)
    created_artist = Artist.new(artist)
    created_artist.save
    created_artist
  end

  def songs
    @songs
  end

  def add_song(song_to_add)
    song_to_add.artist = self unless song_to_add.artist == self #Song is the artist's unless the song is already the artist's
    @songs << song_to_add unless @songs.include?(song_to_add) #add song the artist's collection unless it is already included in the collection
  end

  def genres
    songs.collect {|song| song.genre}.uniq
  end
end
