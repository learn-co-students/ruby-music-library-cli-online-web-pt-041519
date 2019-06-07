module Findable
  
  attr_accessor :name
  
  def initialize(name)
    self.name = name 
    self.class.all << self 
  end 
  
  def save
    self.class.all 
  end  
  
  
  
    

end  