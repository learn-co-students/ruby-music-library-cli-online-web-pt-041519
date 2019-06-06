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
      self.class.all << self
    end

    def self.create(name)
        artist = new(name)
        artist.save
        artist
    end

    def add_song(song)
      song.artist = self unless song.artist # Ref. https://mixandgo.com/learn/if-vs-unless-in-ruby
      songs << song unless songs.include?(song) # "Unless" is the opposite of "if"
    end

    def genres
      songs.map do |song|
        song.genre
      end.uniq
    end
end
