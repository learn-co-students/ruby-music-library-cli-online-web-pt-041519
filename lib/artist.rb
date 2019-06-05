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
    self.class.all << self # adds the Artist instance to the @@all class variable
  end

  def self.create(name)
    artist = new(name)
    artist.save
    artist
  end

  # Associated with song.rb
  def add_song(song)
    song.artist = self unless song.artist # add the current artist's song
    songs << song unless songs.include?(song) # avoid the song to be added if the song already exist
  end

  def genres
    songs.collect do |sn|
      sn.genre
    end.uniq
  end

end
