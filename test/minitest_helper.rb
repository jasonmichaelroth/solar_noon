require 'bundler/setup'
require 'minitest/autorun'

class Minitest::Spec
  class << self
    alias_method :test, :it
  end
end
