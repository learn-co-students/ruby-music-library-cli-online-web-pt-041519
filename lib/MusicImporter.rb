class MusicImporter
  
  attr_accessor :path, :filenames
  
  def initialize(file_path)
    @path = file_path
  end
  
  def files
    @filenames = Dir.entries(path)
    @filenames.delete_if {|filename| filename == "." || filename == ".."}
    @filenames
  end
  
  def import
    files.each do |filename|
      Song.create_from_filename(filename)
    end
  end
  
end