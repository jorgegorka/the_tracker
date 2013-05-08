require 'the_tracker'

class TheTracker::Tracker
  def self.reset
    self.instance.instance_variable_set(:@trackers, [])
  end
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
  config.before { TheTracker::Tracker.reset }
end
