module Concerns
  module Findable
    def find_by_name(name)
        self.all.find{|something|something.name == name}
        #return self
    end
  
    def find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name)
    end
  end #end Findable
end #end Concerns 