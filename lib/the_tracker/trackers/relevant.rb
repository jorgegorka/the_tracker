module TheTracker
  module Trackers
    class Relevant < Base

      # Relevant info
      def initialize(options)
        @token         = options[:token]
        @seg           = options[:seg ]
        @orderId       = options[:orderId]
        super()
      end

      def name
        :relevant
      end

      def body_bottom
        return if !active
        <<-EOF
        <img src="http://ib.adnxs.com/px?id=#{@token}&seg=#{@seg}&orderId=#{@orderId}&t=2" width="1" height="1" />
        EOF
      end
    end
  end
end
