module RidgepoleRake
  module Rails
    module Configuration
      private

      # @note override
      def default_ridgepole_options
        super.merge!({ env: ::Rails.env })
      end
    end
  end
end

RidgepoleRake::Configuration.prepend(RidgepoleRake::Rails::Configuration)
