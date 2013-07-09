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
      regular_trackers[tracker.name] = tracker
    end

    # register a new one time only tracker
    def add_once(tracker)
      one_time_trackers[tracker.name] = tracker
    end

    # registered trackers
    def trackers
      one_time_trackers.empty? ? regular_trackers : regular_trackers.merge(one_time_trackers)
    end

    # Return header content for all registered trackers
    def header
      show_trackers_for(:header)
    end

    # Return body top content for all registered trackers
    def body_top
      show_trackers_for(:body_top)
    end

    # Return body bottom content for all registered trackers
    def body_bottom
      trk_result = show_trackers_for(:body_bottom)
      remove_one_time_trackers
      return trk_result
    end

    private

    def show_trackers_for(position)
      trackers.map do | id, tracker |
        tracker.send(position)
      end.compact.join("\n")
    end

    def regular_trackers
      @regular_trackers ||= {}
    end

    def one_time_trackers
      @one_time_trackers ||= {}
    end

    def remove_one_time_trackers
      @one_time_trackers = {}
    end
  end
end
