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
          (function(){var uv=document.createElement('script');uv.type='text/javascript';uv.async=true;uv.src='//widget.uservoice.com/#{@key_file}.js';var s=document.getElementsByTagName('script')[0];s.parentNode.insertBefore(uv,s)})()
          </script>
        EOF
      end

      def body_bottom
        return if !active
        <<-EOF
          <script type="text/javascript">
          UserVoice = window.UserVoice || [];
          UserVoice.push(['showTab', 'classic_widget', {
            #{@options.to_json}
          }]);
          </script>
        EOF
      end
    end
  end
end
