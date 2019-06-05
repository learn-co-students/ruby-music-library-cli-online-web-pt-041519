class Genre
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
    self.class.all << self # Source: https://medium.com/@sgg2123/vs-self-in-ruby-1d4d88170
  end

  def self.create(name)
    genre = new(name)
    genre.save
    genre
  end

  # Associated with song.rb and artist.rb
  def artists
    songs.collect do |sn|
      sn.artist
    end.uniq
  end

end
