# denv
[![Build Status](https://travis-ci.org/cookpad/denv.svg?branch=master)](https://travis-ci.org/cookpad/denv) [![Gem Version](https://badge.fury.io/rb/denv.svg)](https://badge.fury.io/rb/denv)

denv = dotenv + Docker envfile format

Loads environment variables to `ENV` from `.env` file.

- No special treatments about shell meta characters (e.g. `$`).
- Behaves as over-write.
- Env vars are removed on loading when they are removed from `.env` file. This is useful when use unicorn's graceful reloading.

## Usage
Add this line to your application's Gemfile:

```ruby
source 'https://rubygems.org'

# Place this line at very top of your Gemfile
gem 'denv'
```

And then execute:

```
$ bundle
```

Write your envfile at `.env`:

```sh
AWESOME_SERVICE_CREDENTIAL=xxxxxx
ANOTHER_CREDENTIAL=xxxxxx
```

Then call `Denv.load` in your application initialization. Now you can refer env vars via `ENV`.

```ruby
puts ENV['AWESOME_SERVICE_CREDENTIAL'] #=> "xxxxxx"
```

### Rails integration
denv automatically sets initializer for your Rails application, so you only have to write gem dependency to your Gemfile.

### Command line tool
```
denv --help
echo 'XXX=1' > .env
denv -- env | grep XXX #=> XXX=1
```

## Development
After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/taiki45/denv.


## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
