require 'pry'

class Artist

    @@all = []

    attr_accessor :name, :songs

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
        # song = Song.new(track)
        # song.save
        # song

        # Song.new(track).tap do |song| 
        # song.save
        # end

        Artist.new(artist).tap(&:save)
    end  

    def add_song(song)
        song.artist = self if song.artist == nil
        songs << song if !@songs.include?(song)
    end    
      
end


 