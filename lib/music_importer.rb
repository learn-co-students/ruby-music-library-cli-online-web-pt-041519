class MusicImporter 
  
  attr_accessor :path, :files
  
  def initialize(path)
    @path = path 
  end 
  
  def files 
    dir = Dir.new(@path)
    @files = dir.select {|file| file.match(/\w+/)}
  end 
  
  def import
    self.files.each {|file| Song.create_from_filename(file)}
  end 
  
end 