class Song
  attr_accessor :name
  attr_reader :genre, :artist
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    if artist != nil 
      self.artist= artist
    end
    if genre != nil
      self.genre= genre
    end
    save
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
  
  def self.create(song_name)
    self.new(song_name) 
    self
  end
  
  def artist=(artist)
		@artist = artist 
		artist.add_song(self)
	end

	def genre=(genre)
		@genre = genre
		genre.add_song(self)
	end
	
	def self.find_by_name(title)
	 self.all.find{|an_object|an_object.name == name}
	 return self
	end
	
	def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
	end

end