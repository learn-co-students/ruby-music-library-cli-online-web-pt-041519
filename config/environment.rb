require 'bundler'
Bundler.require

module Concerns
end
require_relative '../lib/concerns/findable'
require './lib/concerns/persistable'

require_all 'lib'
