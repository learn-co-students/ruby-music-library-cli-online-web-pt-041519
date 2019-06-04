require 'pry'
class MusicImporter

 attr_accessor :path

 def initialize(path)
   @path = path
 end

 def files
   Dir.glob("#{path}/*.mp3").map { |file_name| file_name.gsub("#{path}/", "") }
   #binding.pry
 end
 
 def import
   self.files.each {|filename| Song.create_from_filename(filename)}
 end
   
end