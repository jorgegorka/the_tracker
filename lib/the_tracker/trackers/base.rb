module TheTracker
  module Trackers
    # Base class for trackers
    class Base
      attr_accessor :active

      # Trackers are active by default
      def initialize
        @active = true
      end

      # public name
      def name
        raise NotImplementedError
      end

      # code that should appear on the header section
      def header
        raise NotImplementedError
      end
    end
  end
end
