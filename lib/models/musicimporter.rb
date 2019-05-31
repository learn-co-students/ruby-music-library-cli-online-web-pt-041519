class MusicImporter
  attr_accessor :path
  def initialize(path)
    @path = path
  end
  
  def files
    # file_path = "./spec/fixtures/mp3s"
    Dir.entries(@path).select {|f| !File.directory? f}
  end
  
  def import
    files.each do |file_name| 
      Song.create_from_filename(file_name)
    end 
  end
end #end class