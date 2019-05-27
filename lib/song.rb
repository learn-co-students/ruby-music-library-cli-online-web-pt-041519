require "pry"

class Song
   extend Concerns::Findable
   attr_accessor :name, :artist, :genre

   @@all = []

   def initialize(name, artist = nil, genre = nil)
      @name = name
      self.artist = artist if artist != nil
      self.genre = genre if genre != nil
   end
   
   def save
      @@all << self
   end

   def self.all
      @@all
      # binding.pry
   end

   def self.destroy_all
      @@all.clear
   end

   def self.create(song_name)
      song = Song.new(song_name)
      song.save
      song
      # binding.pry
   end
  
   def artist=(artist)
      @artist = artist
      artist.add_song(self)
   end

   def genre=(genre)
      @genre = genre
      if !genre.songs.include?(self)
         genre.songs << self
      end
   end

   def self.new_from_filename(file)
      artist_name = file.chomp(".mp3").split(" - ")
      song_name = self.new(artist_name[1])
      song_name.artist = Artist.find_or_create_by_name(artist_name[0])
      song_name.genre = Genre.find_or_create_by_name(artist_name[2])
      song_name
          # binding.pry
   end
  
    def self.create_from_filename(filename)
      self.new_from_filename(filename).tap(&:save)
   end

end