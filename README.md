# Ruby::Taxii

Ruby TAXII client

Currently under development - likely to break at a moment's notice.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby-taxii'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby-taxii

## Usage
For the base client, create a class:
```ruby
require 'taxii'

class Client; include Taxii::Client; end

c = Client.new; c.user='user'; c.pass='pass'; c.url='http://discovery-url:9000/services/discovery'
```
then call a service for example:
```ruby
c.discover_services
```
For polling:
```ruby
require 'taxii'

pc = Taxii::PollClient.new(user: 'user', pass: 'pass', url: 'http://discovery-url:9000/services/discovery')
count = pc.get_count(Taxii::Messages::PollRequest.new(collection_name: 'collection'))
content_blocks = pc.get_content_blocks(Taxii::Messages::PollRequest.new(collection_name: 'collection', poll_parameters: Taxii::Messages::Parameters::Poll.new(response_type: 'FULL')))
```
## Development


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ryanbreed/ruby-taxii.
