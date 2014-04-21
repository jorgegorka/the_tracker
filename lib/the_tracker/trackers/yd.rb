module TheTracker
  module Trackers
    class Yd < Base

      # Yd info
      def initialize(options)
        @id         = options[:id]
        @product    = options[:product ]
        @order_id   = options[:order_id]
        @cookies    = options.delete(:cookies_allowed) || 1
        super()
      end

      def name
        :yd
      end

      def body_bottom
        return if !active
        <<-EOF
        <iframe src="https://d.254a.com/pixel?id=#{@id}&t=3&cookies_allowed=#{@cookies}&orderid=#{@order_id}&product=#{@product}&secure=true" width="0" height="0" style="display:none;visibility:hidden"></iframe>
        EOF
      end
    end
  end
end
