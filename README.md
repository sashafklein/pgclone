# PGClone

This is a dead simple Postgres/Heroku cloning gem, to make it easier to pull database information from production to local.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pgclone', git: "git://github.com/sashafklein/pgclone.git"
```

And then execute:

    $ bundle

## Usage

The gem is usable either from the command line or from your Rails app. 

### Command Line

Just call `pgclone` with the required arguments specified (or `-h` for more info). Those arguments are `--appname` (your Heroku appname), `--owner` (the local database owner), and `--local-db` (the local database name). `PGClone` will take care of the rest:

```bash
$ pgclone -a my-heroku-app -o my-db-owner-username -l app_development
```

### In Rails App

Set the mandatory configuration options in a config file:

```ruby
# config/initializers/p_g_clone.rb
PGClone.configuration do |config|
    config.appname = 'my-heroku-app'
    config.owner = 'my-db-owner-username'
    config.local_db = 'app_development'
    config.file = 'temporary-dumpfile.dump' # optional
end
```

Then pull the data from your app like so:

```ruby
PGClone::Restore.new.go!
```

Or call directly with an options hash:

```ruby
PGClone::Restore.new({ appname: 'whatever' }).go!
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/sashafklein/pgclone/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
