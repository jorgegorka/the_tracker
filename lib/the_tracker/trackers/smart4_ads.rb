module TheTracker
  module Trackers
    class Smart4Ads < Base

      # Relevant info
      def initialize(options)
        @accountId     = options[:accountId]
        @orderId       = options[:orderId]
        @actionCode    = options[:actionCode]
        @totalCost     = options[:totalCost]
        @scriptId      = options[:scriptId]
        super()
      end

      def name
        :smart4ads
      end
      
      def header
        return if !active
        <<-EOF
        <script id="#{@scriptId}" src="https://www.smart4ads.com/smart4ads/scripts/simpletrackjs.js?accountid=#{@accountId}" type="text/javascript"></script>
        EOF
      end
      

      def body_bottom
        return if !active
        <<-EOF
        <script id="#{@scriptId}" src="https://www.smart4ads.com/smart4ads/api/PVTjs.php?accountid=#{@accountId}&totalcost=#{@totalCost}&orderid=#{@orderId}&actioncode=#{@actionCode}" type="text/javascript"></script>
        EOF
      end
    end
  end
end
