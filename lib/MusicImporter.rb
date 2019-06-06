class MusicImporter
  attr_accessor :path, :files

  def initialize(path)
    @path = path
  end

  def files
    Dir.entries(path).select{|entry| entry.include?(".mp3")}
  end

  def import
    files.map {|file| Song.create_from_filename(file)}
    files
  end
end
