require 'pry'

class Song

    @@all = []

    attr_accessor :name, :artist

    def initialize(name, artist= nil)
        @name = name
        self.artist= artist if artist != nil
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
    
    def self.create(track)
        # song = Song.new(track)
        # song.save
        # song

        # Song.new(track).tap do |song| 
        # song.save
        # end

        Song.new(name).tap(&:save)
    end  

    def artist=(artist_name)
        @artist = artist_name
        artist.add_song(self)
    end    
      
end

