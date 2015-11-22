module RidgepoleRake
  module Rails
    module Configuration
      private

      def default_ridgepole_options
        super.merge!({ env: ::Rails.env })
      end
    end
  end
end

RidgepoleRake::Configuration.__send__(:prepend, RidgepoleRake::Rails::Configuration)
