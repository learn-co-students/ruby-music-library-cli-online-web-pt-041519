require 'pry'
module Concerns::Findable
  
  def find_by_name(name)
    self.all.detect {|song| song.name == name}
  end
  
  def find_or_create_by_name(name)
    finder = find_by_name(name)
    if !finder
      self.create(name)
    else
      return finder
    end
  end
  
  
end