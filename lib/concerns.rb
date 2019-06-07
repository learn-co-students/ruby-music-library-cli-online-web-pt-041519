require 'pry'
module Concerns
   module Findable
  
    attr_accessor :name, :artist, :genre
    
    def save
      self.class.all << self
    end 
    
    def create(name)
      new = self.new(name)
      new.save 
      new
    end  
    
    def destroy_all
      self.all.clear
    end  
    
    def find_by_name(name)
        self.all.find {|item| item.name == name || item == name}
       #binding.pry 
    end  
    
    def find_or_create_by_name(name)
      self.all.uniq!
      a =self.find_by_name(name) 
      if a == nil 
        self.create(name)
      else 
        a
      end  
    end  
    
  end  

end  