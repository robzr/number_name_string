# NumberNameString

Converts between numbers and their cardinal (ex: two) and ordinal (ex: second) names.

Pure Ruby with no dependencies outside of the standard library.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'number_name_string'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install number_name_string

## Usage

NumberNameString has a few interfaces, the simplest is using Module methods:

```ruby
NumberNameString[4032]             # "four hundred thirtytwo"
NumberNameString['six thousand']   # 6000
```

The Convert class can be instantiated and used directly:

```ruby
numname = NumberNameString::Convert.new
numname[2000099]                          # "two million ninetynine"
numname['sixtytwo']                       # 62
```

Or, as a mixin directly on Fixnum and String classes:

```ruby
include NumberNameString
716.to_cardinal            # "seven hundred sixteen"
716.to_ordinal             # "seven hundred sixteenth"
"four thousand two".to_i   # 4002
91346.to_comma             # "91,346"
'five thousand'.to_comma   # "5,000"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/robzr/number_name_string. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

