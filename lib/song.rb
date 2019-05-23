require 'pry'

class Song
    extend Concerns::Findable
    attr_accessor :name, :artist, :genre
    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
    end

    def self.all
        @@all
    end

    def self.destroy_all
        self.all.clear
    end

    def save
        self.class.all << self
    end

    def self.create(name)
        self.new(name).tap(&:save)
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include? self
    end

    def self.new_from_filename(filename)
        data = filename.chomp(".mp3").split(" - ")
        song = self.new(data[1])
        song.artist = Artist.find_or_create_by_name(data[0])
        song.genre = Genre.find_or_create_by_name(data[2])
        song
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename).tap(&:save)
    end
end