class Genre
  extend Concerns::Findable
  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def artists
    self.songs.collect(&:artist).uniq
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(genre_name)
    self.new(genre_name).tap(&:save)
  end

end
