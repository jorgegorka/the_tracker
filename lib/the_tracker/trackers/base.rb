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
        []
      end

      # code that should appear on the body top section
      def body_top
        []
      end

      # code that should appear on the body bottom section
      def body_bottom
        []
      end
    end
  end
end
