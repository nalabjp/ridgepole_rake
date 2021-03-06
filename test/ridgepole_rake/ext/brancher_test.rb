if defined?(::Brancher)
  require 'test_helper'

  class RidgepoleRake::BrancherTest < Minitest::Test
    def setup
      RidgepoleRake.reset
    end


    def test_brancher
      assert RidgepoleRake.config.brancher[:use]

      RidgepoleRake.config.brancher = { use: false }

      assert_equal false, RidgepoleRake.config.brancher[:use]
    end

    def test_inspect_with_db_config_option_and_use_brancher
      action = :apply
      config = RidgepoleRake.config
      config.brancher[:use] = true
      config.ridgepole[:env] = 'custom_environment'
      config.ridgepole[:config] = 'test/fixtures/database_config.yml'

      branch_name = 'use_brancher'
      renamed_yaml = {
        'user' => 'custom_user',
        'password' => 'custom_password',
        'database' => "custom_#{branch_name}",
        'original_database' => 'custom'
      }.to_yaml.chomp!

      exp = "bundle exec ridgepole --apply --file db/schemas/Schemafile --env custom_environment --config #{renamed_yaml}"

      Brancher::DatabaseRenameService.stub(:suffix, "_#{branch_name}") do
        assert_equal exp, RidgepoleRake::Command.new(action, config).inspect
      end
    end
  end
end
