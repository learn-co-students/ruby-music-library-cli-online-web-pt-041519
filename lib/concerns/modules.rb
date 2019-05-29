module Concerns
  module Findable
    # Find instance in @@all from input name
    def find_by_name(name)
      self.all.find{|obj| obj.name == name}
    end

    # Find or create new object from input name
    def find_or_create_by_name(name)
      self.find_by_name(name) || self.create(name)
    end
  end
  
  module Memorable
    # Custom class constructor with name that saves instance to @@all
    def create(name)
      new(name).tap(&:save)
    end

    # Clear @@all
    def destroy_all
      all.clear
    end
  end
end