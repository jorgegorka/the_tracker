module TheTracker
  module ViewHelpers
    def header_tracking_code
      TheTracker::Tracker.instance.header
    end
  end
end
