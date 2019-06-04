class Genre
  extend Concerns::Findable
  attr_accessor  :name



  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def songs
    @songs
  end

  def self.create(name)
    genre = Genre.new(name)
    @@all << genre
    genre
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def artists
    songs.map {|song| song.artist}.uniq
  end
end