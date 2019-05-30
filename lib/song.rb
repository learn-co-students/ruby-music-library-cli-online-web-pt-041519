require 'pry'

class Song
  attr_accessor :name
  attr_reader :artist

  @@all = []

  def initialize(name, artist = nil)
    @name = name
    self.artist = artist #invokes #artist= instead of simply assigning to an @artist instance variable, ensuring that associations are creted upon initialization
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
    @artist == nil ? @artist = artist : @artist = @artist
    #if no variabe given for
    #assigns artist instance

    if self.artist != nil
      @artist.add_song(self)
    end
    @artist
  end
end
