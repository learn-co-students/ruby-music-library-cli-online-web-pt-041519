class Genre
  extend Concerns::Findable

  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    name = name
    @songs = []
    save
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
    new_genre = Genre.new(name)
  end

  def artists
    songs.map {|s| s.artist}.uniq
  end
end
