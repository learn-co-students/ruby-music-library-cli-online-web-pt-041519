require 'pry'

class Genre

    @@all = []

    attr_accessor :name

    def initialize(name)
        @name = name
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
    
    def self.create(genre)
        # song = Song.new(track)
        # song.save
        # song

        # Song.new(track).tap do |song| 
        # song.save
        # end

        Genre.new(genre).tap(&:save)
    end  
      
end


 