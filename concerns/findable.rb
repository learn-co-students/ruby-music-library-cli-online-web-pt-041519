module Concerns::Findable
 # Module code here

 def find_by_name(song_name)
   all.detect {|song_title| song_title.name == song_name}
 end

 def find_or_create_by_name(name)
   find_by_name(name) || create(name)
 end
end