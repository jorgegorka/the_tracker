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

Create a file in config/initializers/tracker.rb

Add all the trackers you need

    TheTracker::Tracker.config do |tmf|
      tmf.add TheTracker::AdForm.new(:id => 123, :pm => 456)
      tmf.add TheTracker::GAnalytics.new(:id => 'UA-1234123-99')
    end

In your views add

    <header>
      <%= header_tracking_code.html_safe %>
    </header>

And that's all the tracking code will be added automatically

If you want to track only certain pages you can do it

For instance, this example will not show the Google Analytics code if `some_condition` evaluates to true

    <header>
      <% TheTracker::Tracker.instance.trackers[:ganalytics].active = some_condition %>
      <%= header_tracking_code.html_safe %>
    </header>

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
