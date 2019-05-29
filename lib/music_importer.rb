require_relative '../config/environment'
require 'pry'
class MusicImporter
  # extend Concerns::Findable

  attr_accessor :path

  # Initialize with path
  def initialize(path)
    @path = path
  end

  # Return array of all mp3 files in path
  def files
    # Navigate to path, then grab mp3 files
    Dir.chdir(@path) { Dir.glob("*.mp3") }
  end

  # Create new song for each input filename
  def import
    files.each { |filename| Song.create_from_filename(filename) }
  end

end