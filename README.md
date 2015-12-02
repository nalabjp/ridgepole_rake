# RidgepoleRake

[![Build Status](https://travis-ci.org/nalabjp/ridgepole_rake.svg?branch=master)](https://travis-ci.org/nalabjp/ridgepole_rake)
[![Code Climate](https://codeclimate.com/github/nalabjp/ridgepole_rake/badges/gpa.svg)](https://codeclimate.com/github/nalabjp/ridgepole_rake)
[![Test Coverage](https://codeclimate.com/github/nalabjp/ridgepole_rake/badges/coverage.svg)](https://codeclimate.com/github/nalabjp/ridgepole_rake/coverage)
[![Dependency Status](https://gemnasium.com/nalabjp/ridgepole_rake.svg)](https://gemnasium.com/nalabjp/ridgepole_rake)

RidgepoleRake provides basic Rake Task for [Ridgepole](https://github.com/winebarrel/ridgepole).

RidgepoleRake supports the version 0.5.0 or later of Ridgepole.

## Installation

Add to your Gemfile:

```ruby
gem 'ridgepole_rake'
```

## Usage

Add to your Rakefile:

```ruby
require 'ridgepole_rake'
load 'tasks/ridgepole_rake.rake'
```

If you are using Rails, it has tasks are loaded automatically.

## Tasks

    $ bundle exec rake -T
    rake ridgepole:apply                # `ridgepole --apply`
    rake ridgepole:apply:dry-run        # `ridgepole --apply --dry-run`
    rake ridgepole:diff                 # `ridgepole --diff` current db and schema file
    rake ridgepole:export               # `ridgepole --export`
    rake ridgepole:merge[file]          # `ridgepole --merge`
    rake ridgepole:merge:dry-run[file]  # `ridgepole --merge --dry-run`
    rake ridgepole:reset                # `rake db:drop`, `rake db:create` and `ridgepole --apply`

## Configuration

RidgepoleRake can configure options of Ridgepole.

### Default configuration
```ruby
# default configuration
RidgepoleRake.config.ridgepole
# => {"config"=>"config/database.yml", "file"=>"db/schemas/Schemafile", "output"=>"db/schemas.dump/Schemafile", "env"=>"development"}
```

### Example
Set by Symbol key.
```ruby
# Symbol key
RidgepoleRake.config.ridgepole[:env] = 'staging'
# => {"config"=>"config/database.yml", "file"=>"db/schemas/Schemafile", "output"=>"db/schemas.dump/Schemafile", "env"=>"staging"}

RidgepoleRake.config.ridgepole[:env]
# => 'staging'
```

Set by String key.
```ruby
# String key
RidgepoleRake.config.ridgepole['env'] = 'production'
# => {"config"=>"config/database.yml", "file"=>"db/schemas/Schemafile", "output"=>"db/schemas.dump/Schemafile", "env"=>"production"}

RidgepoleRake.config.ridgepole['env']
# => 'production'
```

Convert to `ActiveSupport::HashWithIndifferentAccess`.
```ruby
RidgepoleRake.config.ridgepole = { env: 'test' }
RidgepoleRake.config.ridgepole.class
# => ActiveSupport::HashWithIndifferentAccess
```

### Configurable options
see also https://github.com/winebarrel/ridgepole#help

## Rails

If you are using Rails, `:env`'s default value is `Rails.env`.
```ruby
Rails.env
# => production

RidgepoleRake.config.ridgepole[:env]
# => 'production'
```

## Brancher

RidgepoleRake supports [Brancher](https://github.com/naoty/brancher).

Supported version is 0.3.0 or later.

Add to your Gemfile:
```ruby
gem 'brancher', '>= 0.3.0'
```

```ruby
RidgepoleRake.config.brancher[:use]
# => true
```

## Bundler

RidgepoleRake supports Bundler.

```ruby
RidgepoleRake.config.bundler
# => {"use"=>true, "clean_system"=>true}
```

If `RidgepoleRake.config.bundler[:use] == true` and `RidgepoleRake.config.bundler[:clean_system] == true`, Ridgepole will be performed using `Bundler.clean_system`.

## License

MIT License

see [LICENSE.txt](https://github.com/nalabjp/ridgepole_rake/blob/master/LICENSE.txt)
