class Song

  attr_accessor :name, :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=(artist) unless artist == nil #Source: https://docs.ruby-lang.org/en/2.4.0/syntax/control_expressions_rdoc.html
    self.genre=(genre) unless genre == nil
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
    songs = new(name)
    songs.save
    songs
  end

  # Associated to artist.rb
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    self.genre.songs << self unless genre.songs.include?(self)
  end

  def self.find_by_name(song)
    self.all.detect do |fn| # Instantiating all then detect: https://ruby-doc.org/core-2.6.3/Enumerable.html#method-i-detect
      fn.name == song
    end
  end

  def self.find_or_create_by_name(song)
    find_by_name(song) || create(song) # Find a name of the song or create a song using OR || (Line 41 and Line 25 methods)
  end

  def self.new_from_filename(file)
    artist = Artist.find_or_create_by_name(file.split(' - ')[0]) # Define the Artist Name File Format in the beginning of the array "[0]"
    genre = Genre.find_or_create_by_name(file.split(' - ')[2].split('.')[0]) # Define the genre's format (last array "[2]") along the file extension as the first declared array "[0]"
    song_n = file.split(' - ')[1] # Define the name of the song splited by a dash from "[0]" array then designated as "[1]" array
    self.new(song_n, artist, genre) # Create new filename with proper format instances
  end

  def self.create_from_filename(file)
    self.new_from_filename(file).save # Call new_from_filename to save the file
  end

end
