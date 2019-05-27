module Concerns::Findable

  def find_by_name(name)
    self.all.detect{|a| a.name == name}
  end

  def find_or_create_by_name(name)
    return find_by_name(name) if find_by_name(name)
    create(name)
  end
    #  match = self.all.detect{|a| a.name == name}
    # if match == nil
    #    match = self.new(name)
    # end
    # match
end
