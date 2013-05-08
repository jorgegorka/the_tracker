require 'the_tracker/view_helpers'

module TheTracker
  class Railtie < Rails::Railtie
    initializer "the_tracker.view_helpers" do |app|
      ActionView::Base.send :include, ViewHelpers
    end
  end
end
