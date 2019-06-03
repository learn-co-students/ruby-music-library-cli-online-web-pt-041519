require 'pry'

class MusicImporter

  attr_accessor :import
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def files
    Dir.entries(path).select {|entry| entry.include? (".mp3")}
  end

    ##invoke Song.create_from_filename to import files into the library
  def import
    files.each{|file| Song.create_from_filename(file)}
  end

end