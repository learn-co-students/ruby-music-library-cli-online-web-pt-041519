require 'bundler'
Bundler.require

module Concerns
end

require_relative '../lib/concerns/findable.rb' ## important to have this before require_all
require_all 'lib'

