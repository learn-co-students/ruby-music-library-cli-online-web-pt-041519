module Concerns::Persistable


  module InstanceMethods
    def save
      self.class.all << self
    end
  end

  module ClassMethods

    def create(object_name)
      self.new(object_name).tap(&:save)
    end

    def destroy_all
      self.all.clear
    end
  end


end
# Refactoring a ```.create()``` class method.
# ```def self.create(artist_name)
#      artist = Artist.new(artist_name)
#      artist.save
#      artist
#   end```
# I searched online and found the ```.tap()``` method.
# This method passes self to the block and returns self.
# It taps into the middle of your block takes the results
# and perfoms operations on it then returns self.
# That didn't mean much to me either
# until I found the ```array.map(&:method_name)``` idiom.
# When used as listed above the ampersand ```&``` followed by a symol ```:method_name```
# lets you call a method on each element of the array.
# That said, the ```method(&:method_name)``` doesn't just work on arrays.
# by combining ```.tap(&:method_name) I was able to combine a few lines of code.
# ```def self.create(artist_name)
#       self.new(artist_name).tap(&:save)
#       # artist = Artist.new(artist_name)
#       # artist.save
#       # artist
#   end```
# Here are the resources that helped me
# http://ruby-doc.org/core-2.6.2/Object.html#method-i-tap
# https://apidock.com/ruby/Object/tap
# Also using the (&:symbol) to call a method on the element being passed to .tap.
# https://www.brianstorti.com/understanding-ruby-idiom-map-with-symbol/
