ENV["RAILS_ENV"] ||= "test"
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

if ENV['TRAVIS']
  begin
    require 'codeclimate-test-reporter'
    require 'simplecov'
    SimpleCov.start
  rescue LoadError
  end
end

begin
  require 'pry'
rescue LoadError
end

require 'ridgepole_rake'

require 'minitest/reporters'
Minitest::Reporters.use!

require 'minitest/autorun'
