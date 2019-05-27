
def list_songs
   Song.all.sort_by(&:name).each_with_index do |song, index|
       puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
   end
end

def list_artists
   Artist.all.sort_by(&:name).each_with_index do |song, index|
       puts "#{index+1}. #{song.artist.name}"
   end
end

# def list_genres
# end

# def list_songs_by_artist
# end

