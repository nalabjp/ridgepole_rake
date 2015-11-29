ENV["RAILS_ENV"] ||= "test"
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

begin
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
rescue LoadError
end

begin
  require 'pry'
rescue LoadError
end

require 'ridgepole_rake'

require 'minitest/reporters'
Minitest::Reporters.use!

require 'minitest/autorun'
