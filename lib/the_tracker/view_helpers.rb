module TheTracker
  module ViewHelpers
    def header_tracking_code
      TheTracker::Tracker.instance.header
    end

    def body_top_tracking_code
      TheTracker::Tracker.instance.body_top
    end

    def body_bottom_tracking_code
      TheTracker::Tracker.instance.body_bottom
    end
  end
end
