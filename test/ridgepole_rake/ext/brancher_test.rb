if defined?(::Brancher)
  require 'test_helper'

  class RidgepoleRake::BrancherTest < Minitest::Test
    def setup
      RidgepoleRake.reset
    end

    def test_use_brancher
      assert RidgepoleRake.config.brancher[:use]

      RidgepoleRake.configure do |config|
        config.brancher[:use] = false
      end

      assert_equal false, RidgepoleRake.config.brancher[:use]
    end

    def test_commnad_with_db_config_option_and_use_brancher
      action = :apply
      config = RidgepoleRake.config
      config.brancher[:use] = true
      config.ridgepole[:env] = 'custom_environment'
      config.ridgepole[:config] = 'test/fixtures/database_config.yml'

      branch_name = 'use_brancher'
      renamed_yaml = <<-EOYAML
---
user: custom_user
password: custom_password
database: custom_#{branch_name}
original_database: custom
      EOYAML
      renamed_yaml.chomp!

      exp = "bundle exec ridgepole --apply --file db/schemas/Schemafile --env custom_environment --config #{renamed_yaml}"

      Brancher::DatabaseRenameService.stub(:suffix, "_#{branch_name}") do
        assert_equal exp, RidgepoleRake::Command.new(action, config).command
      end
    end
  end
end
