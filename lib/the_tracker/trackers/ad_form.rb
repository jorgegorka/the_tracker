module TheTracker
  module Trackers
    class AdForm < Base

      # AdForm info pm and id
      def initialize(options)
        @pm = options[:pm]
        @id = options[:id]
        super()
      end

      def name
        :adform
      end

      def header
        return if !active
        <<-EOF
      <!-- Adform Tracking Code BEGIN -->
      <script type="text/javascript">
      var _adftrack = {
      pm: #{@pm},
      id: #{@id}
      };
      (function(){var s=document.createElement('script');s.type='text/javascript';s.async=true;s.src='https://track.adform.net/serving/scripts/trackpoint/async/';var x = document.getElementsByTagName('script')[0];x.parentNode.insertBefore(s, x);})();
      </script>
      <noscript>
      <p style="margin:0;padding:0;border:0;">
      <img src="https://track.adform.net/Serving/TrackPoint/?pm=#{@pm}&amp;lid=#{@id}" width="1" height="1" alt="" />
      </p>
      </noscript>
      <!-- Adform Tracking Code END -->
      EOF
      end
    end
  end
end
