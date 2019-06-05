module Concerns::Findable
  # Module code here
  def find_by_name(name)
    self.all.detect do |fn| # Instantiating all then detect: https://ruby-doc.org/core-2.6.3/Enumerable.html#method-i-detect
      fn.name == name
    end
  end

  def find_or_create_by_name(song)
    find_by_name(song) || create(song)
  end


end
