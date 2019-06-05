class MusicLibraryController

  attr_accessor :path, :importer, :alphabetized_song_list

  def initialize(path = './db/mp3s') # => initialization of optional path with file extension of the list of songs.
    MusicImporter.new(path).import  # => call MusicImporter class to create a new path of the songs to import.
  end

  def call
    input = "" # => create an empty input prompt (spec file will acknowledge it due to $stdout and StringIO).
    # => Source: https://stackoverflow.com/questions/23349863/testing-stdin-in-ruby
    until input == "exit"
      input = gets.chomp # => rspec $stdout values returned with removed seperator.
      case input # => instantiates each $stdout user options.
      when exit # => if user type "exit" it terminates the loop for cli interface.
        puts "Goodbye."
      end
    end
  end

end
