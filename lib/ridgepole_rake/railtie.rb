require 'rails/railtie'

module RidgepoleRake
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load "tasks/ridgepole_rake.rake"
    end
  end
end
