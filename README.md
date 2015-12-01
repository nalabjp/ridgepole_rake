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

### apply

    $ bundle exec ridgepole:apply 

## License

MIT License

see [LICENSE.txt](https://github.com/nalabjp/ridgepole_rake/blob/master/LICENSE.txt)
