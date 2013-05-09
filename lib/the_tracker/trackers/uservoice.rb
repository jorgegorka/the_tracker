module TheTracker
  module Trackers
    class Uservoice < Base
      require 'json'

      # AdForm info pm and id
      def initialize(options)
        @options = options
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
         (function () {
         var load_uv = function () {
         var uv = document.createElement('script');
         uv.type = 'text/javascript';
         uv.async = true;
         uv.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'widget.uservoice.com/vVliA5rgJILIaJ3PD8wDw.js';
         var s = document.getElementsByTagName('script')[0];
         s.parentNode.insertBefore(uv, s);
         window.UserVoice.push(['showTab', 'classic_widget', uvOptions]);
         },
         try_uv =  function () {
         try {
         if ((typeof document === 'object') && (document !== null) &&
         (typeof document.body === 'object') && (document.body !== null) &&
         (typeof document.getElementsByTagName("script")[0] === 'object') &&
         (typeof document.getElementsByTagName("script")[0].parentNode === 'object') &&
         ((typeof document.getElementsByTagName("script")[0].parentNode.insertBefore === 'object') ||
         (typeof document.getElementsByTagName("script")[0].parentNode.insertBefore === 'function'))
         ) {
         load_uv();
         } else {
         window.setTimeout(try_uv, 10);
         }
         } catch( error ) {
         window.setTimeout(try_uv, 10);
         }
         }
         try_uv();
         }());
         </script>
      EOF
      end
    end
  end
end
