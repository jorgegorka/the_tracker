module TheTracker
  module Trackers
    class GUniversal < Base

      attr_accessor :name

      # Universal Analytics
      def initialize(options)
        @name    = options.delete(:name) || :guniversal
        @options = options
        super()
      end

      def add_transaction(tid=0, store='', total=0, tax=0, shipping=0)
        tid = Time.now.to_i if (tid.nil?) or (tid.to_s == '0')
        @transaction = EcommerceTransaction.new(tid, store, total, tax, shipping)
      end

      def add_transaction_item(sku='', product='', category='', price=0, quantity=0)
        @transaction.add_item(sku, product, category, price, quantity)
      end

      def add_custom_var(type, index, value)
        if (type == :dimension)
          custom_dimensions[index] = value
        else
          custom_metrics[index] = value
        end
      end

      def add_user_id(uid)
        @uid = uid
      end

      def header
        return if !active
        <<-EOF
        <!-- Google Analytics -->
        <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
        ga('create', '#{@options[:id]}', {#{create_conf}});
        #{extra_conf}
        ga('#{name}.send', 'pageview');
        ga('require', 'displayfeatures');
        ga('require', 'linkid', 'linkid.js');
        #{set_transactions}
        </script>
        <!-- End Google Analytics -->
        EOF
      end

      private

      def create_conf
        [account_name, allow_linker, user_id].compact.join(', ')
      end

      def account_name
        "'name': '#{name}'"
      end

      def allow_linker
        "'allowLinker': true" if @options[:allow_linker]
      end

      def user_id
        "'userId': '#{@uid}'" if @uid
      end

      def extra_conf
        conf = ''
        conf << "ga('#{name}.require', 'linker');\n"
        conf << "ga('linker:autoLink', #{@options[:domain_name]});\n" if @options[:domain_name]
        conf << set_custom_dimensions
        conf << set_custom_metrics
        conf
      end

      def set_custom_dimensions
        custom_dimensions.map do | index, value |
          "ga('#{name}.set', 'dimension#{index}', '#{value}');"
        end.join(' ')
      end

      def set_custom_metrics
        custom_metrics.map do | index, value |
          "ga('#{name}.set', 'metric#{index}', '#{value}');"
        end.join(' ')
      end

      def set_transactions
        return '' unless @transaction
        conf = "ga('#{name}.require', 'ecommerce', 'ecommerce.js');\n"
        conf << "ga('#{name}.ecommerce:addTransaction', { 'id': '#{@transaction.id}', 'affiliation': '#{@transaction.store}', 'revenue': '#{@transaction.total}', 'shipping': '#{@transaction.shipping}', 'tax': '#{@transaction.tax}' });\n"
        conf << @transaction.items.map do |item|
          "ga('#{name}.ecommerce:addItem', {'id': '#{@transaction.id}', 'name': '#{item.product}', 'sku': '#{item.sku}', 'category': '#{item.category}', 'price': '#{item.price}', 'quantity': '#{item.quantity}'});\n"
        end.join('\n')
        conf << "ga('#{name}.ecommerce:send');\n"
        @transaction = nil
        conf
      end

      def custom_dimensions
        @custom_dimensions ||= {}
      end

      def custom_metrics
        @custom_metrics ||= {}
      end
    end

    class EcommerceItem < Struct.new(:sku, :product, :category, :price, :quantity)
    end

    class EcommerceTransaction < Struct.new(:id, :store, :total, :tax, :shipping)
      def add_item(sku, product, category, price, quantity)
        items << EcommerceItem.new(sku, product, category, price, quantity)
      end

      def items
        @items ||= []
      end
    end
  end
end
