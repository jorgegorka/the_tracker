module TheTracker
  module Trackers
    class Gtm < Base

      attr_accessor :data_layer

      # Gtm info
      def initialize(options)
        @gtmid = options[:gtmid]
        super()
      end

      def name
        :gtm
      end

      def body_top
        return if !active
        <<-EOF
          #{show_data_layer}
          <!-- Google Tag Manager -->
          <noscript><iframe src="//www.googletagmanager.com/ns.html?id=#{@gtmid}"
          height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
          <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
          new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
          j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
          '//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
          })(window,document,'script','dataLayer','#{@gtmid}');</script>
          <!-- End Google Tag Manager -->
        EOF
      end

      def add_data_layer(data, value)
        data_layer[data] = value
      end

      private

      def data_layer
        @data_layer ||= {}
      end

      def show_data_layer
        return if data_layer.empty?
        <<-EOF
          <script>
          dataLayer = [{
          #{data_layer_to_string}
          }];
          </script>
        EOF
      end

      def data_layer_to_string
        data_layer.map{|k,v| "'#{k}': '#{v}'"}.join(',')
      end
    end
  end
end
