require "pry"

class MusicImporter
attr_accessor :path

def initialize(path)
  @path = path
end

def files
Dir.glob("#{path}/*.mp3").collect{|p| p.gsub("#{path}/", "")}
end


def import
  files.each do |file|
  song = Song.create_from_filename(file)
  end
end

end
