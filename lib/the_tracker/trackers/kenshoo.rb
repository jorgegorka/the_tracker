module TheTracker
  module Trackers
    class Kenshoo < Base

      # Kenshoo info
      def initialize(options)
        @token         = options[:token]
        @type          = options[:type]
        @val           = options[:val]
        @orderId       = options[:orderId]
        @promoCode     = options[:promoCode]
        @valueCurrency = options[:valueCurrency]
        @trackEvent    = options[:trackEvent]
        super()
      end

      def name
        :kenshoo
      end

      def body_top
        return if !active
        <<-EOF
        <script type=text/javascript>
          var hostProtocol = (("https:" == document.location.protocol) ? "https" : "http");
          document.write('<scr'+'ipt src="', hostProtocol+
            '://#{@trackEvent}.xg4ken.com/media/getpx.php?cid=#{@id}','" type="text/JavaScript"><\/scr'+'ipt>');
        </script>
        <script type=text/javascript>
          var params = new Array();
          params[0]='id=#{@token}';
          params[1]='type=#{@type}';
          params[2]='val=#{@val}';
          params[3]='orderId=#{@orderId}';
          params[4]='promoCode=#{@promoCode}';
          params[5]='valueCurrency=#{@valueCurrency}';
          params[6]='GCID='; //For Live Tracking only
          params[7]='kw='; //For Live Tracking only
          params[8]='product='; //For Live Tracking only
          k_trackevent(params,'#{@trackEvent}');
        </script>
        <noscript>
          <img src="https://1191.xg4ken.com/media/redir.php?track=1&token=#{@token}&type=#{@type}&val=#{@val}&orderId=#{@orderId}&promoCode=#{@promoCode}&valueCurrency=#{@valueCurrency}&GCID=&kw=&product=" width="1" height="1">
        </noscript>
        EOF
      end
    end
  end
end
