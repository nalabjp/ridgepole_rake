ENV["RAILS_ENV"] ||= "test"
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

if Gem.loaded_specs['brancher']
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

require 'pry'
require 'ridgepole_rake'

require 'minitest/stub_any_instance'
require 'minitest/reporters'

Minitest::Reporters.use!

require 'minitest/autorun'
