class MusicImporter
  attr_accessor :path
  def initialize(path)
    @path = path
  end
  
  def files
    file_path = "./spec/fixtures/mp3s"
    Dir.entries(file_path).select {|f| !File.directory? f}
  end
  
end