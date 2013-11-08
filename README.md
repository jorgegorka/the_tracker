# TheTracker

A Gem to help you add tracker components to your application.  Instead of having to write javascript code to add this trackers you can use plain pure ruby.

Currently this components are supported:

  Google Analytics

  Uservoice

  Ad Form

  Google Ad Services

  Kenshoo Conversion Pixel

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

If you want to add some trackers in the body you can add:

    <body>
      <%= body_top_tracking_code.html_safe %>

      ... your page html ...

      <%= body_bottom_tracking_code.html_safe %>
    </body>

And that's all the tracking code will be added automatically

Sometimes you only want to track certain pages:

For instance, this example will not show the Google Analytics code if `some_condition` evaluates to true

    <header>
      <% TheTracker::Tracker.instance.trackers[:ganalytics].active = some_condition %>
      <%= header_tracking_code.html_safe %>
    </header>

You can add a tracking code only once:

    TheTracker::Tracker.config do |tmf|
      tmf.add_once TheTracker::Trackers::Uservoice.new('YOUR_KEY', {:forum_id => 123, :tab_label => 'Say Hi and disappear!'})
    end


## Available Trackers

### AdFrom

      TheTracker::Trackers::AdForm.new(:pm => 123, :id => 444)

### Uservoice

      TheTracker::Trackers::Uservoice.new(
        'THE_KEY',
        {
        mode: 'full',
        primary_color: '#ff0000',
        link_color: '#007dbf',
        default_mode: 'support',
        forum_id: 111,
        tab_label: 'Say Hi!',
        tab_color: '#cc0000',
        tab_position: 'middle-left',
        tab_inverted: true
        }
      )

### Google Analytics

#### Regular tracking code
      TheTracker::Trackers::GAnalytics.new(:id => 'UA-111111-11')

You can optionally set domain name and allow linker

      TheTracker::Trackers::GAnalytics.new(:id => 'UA-111111-11', :domain_name => 'mydomain.com', :allow_linker => true)

#### Add an e-commerce transaction
      TheTracker::Tracker.instance.trackers[:ganalytics].add_transaction(tid=0, store='', total=0, tax=0, shipping=0, city='', state='', country='')

Yo don't need to specify an id.  If id is zero the transaction id will be the current timestamp

To add items to the transaction:

      TheTracker::Tracker.instance.trackers[:ganalytics].add_transaction_item(sku='', product='', category='', price=0, quantity=0)

#### Add custom vars

      TheTracker::Tracker.instance.trackers[:ganalytics].add_custom_var(index, name, value, scope)

#### Track an event

      TheTracker::Tracker.instance.trackers[:ganalytics].track_event(category, action, label='', value=0, non_interactive=false)

### Google AdServices

      TheTracker::Trackers::GAdServices.new(
        id: 'UA-111111-11'
        language: 'en',
        format: '1',
        color: 'ffffff',
        label: 'qwerty',
        value: '0'
      )

### Kenshoo Conversion Pixel

      TheTracker::Trackers::Kenshoo.new(
        token: '999'
        type: 'conv',
        val: '0',
        orderId: '88988',
        promoCode: 'easter',
        valueCurrency: 'EUR',
        trackEvent: '1234'
      )
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

## Log

### Version 1.0.0

Everything is stable so time to bump version to 1.0.0

Added Kenshoo conversion pixel support

### Version 0.5.0

Now you can add a tracker that will be displayed only once and removed from subsequent requests.

### Version 0.4.6

Fixed bug that keeped information about transactions on each page load.  Now transaction information is displayed only once.
