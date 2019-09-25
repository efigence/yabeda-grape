# Yabeda::Grape

Metrics for monitoring Grape endpoints.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yabeda-grape'

# Then add monitoring system adapter, e.g.:
# gem 'yabeda-prometheus'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yabeda-grape

## Usage

```ruby
# initializers/yabeda.rb

Yabeda::Grape.bind_metrics
```

## Metrics

* `grape_requests_total` - Total requests received
* `grape_request_duration_seconds` - Request duration (in seconds)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/efigence/yabeda-grape.
