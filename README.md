# Kickme

Just some code I've written that pulls historical match data from leagues available on football-data.co.uk. Eventually this data will power either an API or site that people can use.

To download individual CSVs go to `csv` folder and have a look around and choose what you want.

To download over 100k fixture data all in one file, download `csv/all.csv`.

If you want to pull down data on your own for whatever reason see below!

## Note about data

Data for different seasons vary, i.e. some columns are present while others aren't. The `csv/all.csv` file normalizes all seasons to just have blanks for missing data.

None of the data has been checked for accuracy and any errors present comes from source.

Checkout the glossary of each data field [here](http://www.football-data.co.uk/notes.txt).

I've added 3 extra fields for season, league, and country for `csv/all.csv`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kickme'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kickme

## Usage

If you've installed the gem globally you do not need to prepend following commands with `bundle exec`.


### Download data

To fetch latest data for all countries in config.json:

`bundle exec kickme download`

To download latest data for specific countries:

`bundle exec kickme --countries spain england france`

Please don't do this too often or at all... Don't want to mess with the person's server.


### Combine data

To combine all csv files:

`bundle exec kickme combine`

This command deletes previous `csv/all.csv` and replaces it with all new data.

If you want to only have a subset of fields, checkout of `config.json` and remove whatever fields you don't want.

### Data is version controlled

Data is versioned controlled just so that it shows up on Github for people to download. Feel free to ignore it in your own project.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/kickme. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

