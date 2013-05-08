# TheTracker

Tracker Motherfucker

Yes, I know tracking people sucks, but that's the way it goes

## Installation

Add this line to your application's Gemfile:

    gem 'the_tracker'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install the_tracker

## Usage

`
TheTracker::Tracker.config do |tmf|

  tmf.add TheTracker::AdForm.new(:id => 123, :pm => 456)

end
`


## Author
 Created by Jorge Alvarez
 @jorgealvarez
 http://www.alvareznavarro.es

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
