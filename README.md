[![Gem Version](https://badge.fury.io/rb/the_tracker.svg)](http://badge.fury.io/rb/the_tracker)

Simple way to add Google analytics, universal analytics, uservoice to your rails app

# TheTracker

A Gem to help you add tracker components to your application.  Instead of having to write javascript code to add this trackers you can use plain pure ruby.

Currently this components are supported:

  Google Analytics

  Google Universal Analytics

  Google Tag Mangaer

  Uservoice

  Ad Form

  Google Ad Services

  Kenshoo Conversion Pixel

  Relevant Traffic Conversion Pixel

  YD RTB Pixel

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
      tmf.add TheTracker::Trackers::Uservoice.new('YOUR_KEY', {:forum_id => 123, :tab_label => 'Say Hi!'})
      tmf.add TheTracker::Trackers::GAnalytics.new(:id => 'UA-1234123-99')
    end

In your views add

    <header>
      <%= header_tracking_code.html_safe %>
    </header>

If the tracker needs to add code into the body:

    <body>
      <%= body_top_tracking_code.html_safe %>

      ... your page html ...

      <%= body_bottom_tracking_code.html_safe %>
    </body>

And that's all, the tracking code will be added automatically

Sometimes you only want to track certain pages:

For instance, this example will show the Google Analytics code only if `some_condition` evaluates to true

    <header>
      <% TheTracker::Tracker.instance.trackers[:ganalytics].active = some_condition %>
      <%= header_tracking_code.html_safe %>
    </header>

You can add a tracking code on a single page:

    TheTracker::Tracker.config do |tmf|
      tmf.add_once TheTracker::Trackers::Uservoice.new('YOUR_KEY', {:forum_id => 123, :tab_label => 'Say Hi and disappear!'})
    end

## [Documentation](https://github.com/jorgegorka/the_tracker/wiki)

Read the documentation to find details about how to implement each pixel available.


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

## License

The Tracker is released under the [MIT License](http://www.opensource.org/licenses/MIT).

## Log

### Version 1.3.0

YD RTB support

### Version 1.2.3

Fixed bug with namespace

### Version 1.2.2

Support for more than one Universal analytics account

### Version 1.2.1

Support for userId in Universal analytics

### Version 1.2.0

Added Universal analytics

### Version 1.1.2

Added Relevant Traffic conversion pixel support

### Version 1.0.0

Everything is stable so time to bump version to 1.0.0

Added Kenshoo conversion pixel support

### Version 0.5.0

Now you can add a tracker that will be displayed only once and removed from subsequent requests.

### Version 0.4.6

Fixed bug that keeped information about transactions on each page load.  Now transaction information is displayed only once.
