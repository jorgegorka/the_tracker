module TheTracker
  module Trackers
    class GAdServices < Base

      # GAdService info id, language, format, color, label and value
      def initialize(options)
        @id = options[:id]
        @language = options[:language]
        @format = options[:format]
        @color = options[:color]
        @label = options[:label]
        @value = options[:value]
        super()
      end

      def name
        :gadservices
      end

      def header
        return if !active
        <<-EOF
      <!-- Google Code for Cliente Potencial Conversion Page BEGIN -->
      <script type="text/javascript">
      /* <![CDATA[ */
      var google_conversion_id = #{@id};
      var google_conversion_language = \"#{@language}\";
      var google_conversion_format = \"#{@format}\";
      var google_conversion_color = \"#{@color}\";
      var google_conversion_label = \"#{@label}\";
      var google_conversion_value = #{@value};
      /* ]]> */
      </script>
      <script type=\"text/javascript\" src=\"//www.googleadservices.com/pagead/conversion.js\">
      </script>
      <noscript>
      <div style=\"display:inline;\">
        <img height=\"1\" width=\"1\" style=\"border-style:none;\" alt=\"\" src=\"//www.googleadservices.com/pagead/conversion/#{@id}/?value=#{@value}&label=#{@label}&guid=ON&script=0\"/>
      </div>
      </noscript>
      <!-- Google Code for Cliente Potencial Conversion Page END -->
      EOF
      end
    end
  end
end
