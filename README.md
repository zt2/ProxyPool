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

Get anonymous proxy randomly:

```ruby
require 'proxy_pool'

ProxyPool.get_anonymous_proxy
=> {"country"=>"RU", "anonymity"=>"high_anonymous", "from"=>"txt", "type"=>"https", "export_address"=>["94.242.58.14", "94.242.58.14"], "port"=>1448, "host"=>"94.242.58.14", "response_time"=>1.7}
```

Get transparent proxy randomly:

```ruby
require 'proxy_pool'

ProxyPool.get_transparent_proxy
=> {"country"=>"ID", "anonymity"=>"anonymous", "from"=>"txt", "type"=>"http", "export_address"=>["35.192.136.167", "118.97.191.162", "35.192.136.167"], "port"=>80, "host"=>"118.97.191.162", "response_time"=>3.04}
```

Use filter:

```ruby
require 'proxy_pool'

ProxyPool.get_anonymous_proxy(type: 'https', country: 'ID', port: 80, from: 'txt')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zt2/proxy_pool.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
