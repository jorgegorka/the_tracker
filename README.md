# TheTracker

A Gem to help you add tracker components to your application

Currently this components are supported:

  Google Analytics

  Uservoice

  Ad Form

  Google Ad Services

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
      tmf.add TheTracker::Trackers::Uservoice.new(:forum_id => 123, :tab_label => 'Say Hi!')
      tmf.add TheTracker::Trackers::GAnalytics.new(:id => 'UA-1234123-99')
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

## Available Trackers

### AdFrom

      TheTracker::Trackers::AdForm.new(:pm => 123, :id => 444)

### Uservoice

      TheTracker::Trackers::Uservoice.new(
        mode: 'full',
        primary_color: '#ff0000',
        link_color: '#007dbf',
        default_mode: 'support',
        forum_id: 111,
        tab_label: 'Say Hi!',
        tab_color: '#cc0000',
        tab_position: 'middle-left',
        tab_inverted: true
      )

### Google Analytics

      TheTracker::Trackers::GAnalytics.new(:id => 'UA-111111-11')

### Google Analytics

      TheTracker::Trackers::GAdservices.new(:id => 'UA-111111-11')

## Author

 Created by Jorge Alvarez

 @jorgealvarez

 http://www.alvareznavarro.es

 I would like to thanks to the [Sage One](http://www.sageone.es) team for their support in the development of this gem

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
