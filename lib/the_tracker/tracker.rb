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
      end.compact.join("\n")
    end

    # Return body top content for all registered trackers
    def body_top
      trackers.map do | id, tracker |
        tracker.body_top
      end.compact.join("\n")
    end

    # Return body bottom content for all registered trackers
    def body_bottom
      trackers.map do | id, tracker |
        tracker.body_bottom
      end.compact.join("\n")
    end
  end
end
