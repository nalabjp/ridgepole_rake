require 'active_support/core_ext/hash'
require 'active_support/configurable'
require 'ridgepole_rake/configuration'
require 'ridgepole_rake/command'
require 'ridgepole_rake/tasks'
require 'ridgepole_rake/version'

module RidgepoleRake
  extend self

  def configure
    yield config
  end

  def config
    @config ||= Configuration.new
  end
end
