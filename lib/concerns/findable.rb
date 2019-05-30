module Findable
  module ClassMethods
  
  def find_by_name(name)
    self.all.detect {|song| song.name == name}
  end
  
  def find_or_create_by_name(name)
    finder = self.find_by_name(name)
    if !finder
      self.new.tap do |o|
        o.name = name
    else
      return finder
    end
  end
  
  end
  
end