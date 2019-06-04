class Song
  extend Concerns::Findable
  attr_accessor  :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    #@artist = artist
    self.artist= artist if artist != nil
    self.genre= genre if genre != nil
  end

  def self.create(name)
    song = Song.new(name)
    @@all << song
    song
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

   def artist=(artist)
     @artist = artist #defining the instance variable @artist
     artist.add_song(self) #invoking the add_song method on the defined artist
   end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  # def self.find_by_name(name)
  #   song = @@all.find {|song| song.name == name}
  # end
  #
  # def self.find_or_create_by_name(name)
  #   find_by_name(name) || song = Song.create(name)
  # end

  def self.new_from_filename(file_name)
    arguments = file_name.split(" - ")
    artist= Artist.find_or_create_by_name(arguments[0])
    song_name = arguments[1]
    genre = Genre.find_or_create_by_name(arguments[2].chomp(".mp3"))
    song = Song.new(song_name, artist, genre)
  end
  
  def self.create_from_filename(filename)
    arg = filename.split(" - ")
    if self.find_by_name(arg[1]) == nil
      song = self.new_from_filename(filename)
    end
    song.save
    song
  end
end
