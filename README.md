# denv
[![Build Status](https://travis-ci.org/taiki45/denv.svg?branch=master)](https://travis-ci.org/taiki45/denv) [![Gem Version](https://badge.fury.io/rb/denv.svg)](https://badge.fury.io/rb/denv)

denv = dotenv + Docker envfile format

No special treatments about shell meta characters (e.g. `$`).

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

Then call `Denv.load` in your application initialization.

### Rails integration
Denv automatically set initializer for your Rails application, so you only have to write gem dependency to your Gemfile.

## Development
After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/taiki45/denv.


## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
