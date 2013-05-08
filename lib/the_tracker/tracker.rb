require 'singleton'

module TheTracker
  # Common tracker behaviour
  class Tracker
    include Singleton

    def self.config
      yield self.instance if block_given?
    end

    # register a new tracker
    def add(tracker)
      trackers[tracker.name] = tracker
    end

    # registered trackers
    def trackers
      @trackers ||= {}
    end

    # Return header content for all registered trackers
    def header
      trackers.map do | id, tracker |
        tracker.header
      end.join('\n')
    end
  end
end
