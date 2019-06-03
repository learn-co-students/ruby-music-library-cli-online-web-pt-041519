

class MusicImporter
    attr_accessor :path
  
    def initialize(path)
      @path = path
    end
    
    def files
      Dir.entries(path).select {|entry| entry.include?(".mp3")}.map{|file| File.basename(file)}

    end
    
    def import
      files.each {|file| Song.create_from_filename(file)}
    end
  
end
