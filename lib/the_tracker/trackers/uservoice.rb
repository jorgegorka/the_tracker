module TheTracker
  module Trackers
    class Uservoice < Base
      require 'json'

      # AdForm info pm and id
      def initialize(key_file, options)
        @options  = options
        @key_file = key_file
        super()
      end

      def name
        :uservoice
      end

      def header
        return if !active
        <<-EOF
          <script type="text/javascript">
          var uvOptions = #{@options.to_json};
          (function() {
          var uv = document.createElement('script'); uv.type = 'text/javascript'; uv.async = true;
          uv.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'widget.uservoice.com/#{@key_file}.js';
          var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(uv, s);
          })();
          </script>
        EOF
      end
    end
  end
end
