# ProxyPool

ProxyPool is a wrapper for [fate0/proxylist](https://github.com/fate0/proxylist)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'proxy_pool'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install proxy_pool

## Usage

Require

```ruby
require 'proxy_pool'
```

Get proxy randomly:

```ruby
ProxyPool.get
```

Or you can create any condition in block

```ruby
# Select proxy by response time
ProxyPool.get { |proxy| proxy['response_time'] < 2 }
```

Get high anonymous proxy:

```ruby
ProxyPool.get_high_anonymous_proxy
```

Get proxy by country

```ruby
ProxyPool.get_by_country('us')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zt2/proxy_pool.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
