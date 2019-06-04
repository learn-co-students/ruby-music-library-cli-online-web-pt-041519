class MusicImporter

  attr_reader :path
  def initialize(path)
    @path = path
  end

  def files
    Dir.entries(@path).select {|f| !File.directory? f}
  end

  def import
    #binding.pry
    files.each{|filename| Song.create_from_filename(filename)}
  end


end