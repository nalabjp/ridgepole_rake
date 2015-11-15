require 'active_support/core_ext/hash'
require 'active_support/configurable'
require 'ridgepole_rake/configuration'
require 'ridgepole_rake/command'
require 'ridgepole_rake/tasks'
require 'ridgepole_rake/version'
begin
  require 'brancher'
  require 'ridgepole_rake/ext/brancher'
rescue LoadError
end
begin
  require 'bundler'
  require 'ridgepole_rake/ext/bundler'
rescue LoadError
end

module RidgepoleRake
  extend self

  def configure
    yield config
  end

  def config
    @config ||= Configuration.new
  end
end
