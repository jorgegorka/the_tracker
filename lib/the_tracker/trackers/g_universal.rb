module TheTracker
  module Trackers
    class GUniversal < Base

      # Universal Analytics
      def initialize(options)
        @name    = options.delete(:name) || :guniversal
        @options = options
        super()
      end

      def name
        @name
      end

      def add_transaction(tid=0, store='', total=0, tax=0, shipping=0, city='', state='', country='')
        tid = Time.now.to_i if (tid.nil?) or (tid.to_s == '0')
        @transaction = Transaction.new(tid, store, total, tax, shipping, city, state, country)
      end

      def add_transaction_item(sku='', product='', category='', price=0, quantity=0)
        @transaction.add_item(sku, product, category, price, quantity)
      end

      def add_custom_var(index, name, value, scope)
        custom_vars[index] = [name, value, scope]
      end

      def track_event(category, action, label='', value=0, non_interactive=false)
        "_gaq.push(['_trackEvent', '#{category}', '#{action}', '#{label}', #{value}, #{non_interactive}]);"
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
        ga('create', '#{@options[:id]}', 'auto', {'allowLinker': true});
        ga('send', 'pageview');
        #{extra_conf}
        </script>
        <!-- End Google Analytics -->
        EOF
      end

      private

      def extra_conf
        conf = ''
        conf << "ga('require', 'linker');\n"
        conf << "ga('linker:autoLink', [#{@options[:domain_name]"]);\n" if @options[:domain_name]
        conf << set_custom_vars
        conf << set_transactions
        conf
      end

      def set_custom_vars
        custom_vars.map do | index, cv |
          "_gaq.push(['_setCustomVar', #{index}, '#{cv[0]}', '#{cv[1]}', '#{cv[2]}']);"
        end.join('\n')
      end

      def set_transactions
        return '' unless @transaction
        conf = "ga('require', 'ecommerce', 'ecommerce.js');\n"
        conf = "ga('ecommerce:addTransaction', { 'id': '#{@transaction.id}', 'affiliation': '#{@transaction.store}', 'revenue': '#{@transaction.total}', 'shipping': '#{@transaction.shipping}', 'tax': '#{@transaction.tax}' });\n"
        conf << @transaction.items.map do |item|
          "ga('ecommerce:addItem', {'id': '#{@transaction.id}', 'name': '#{item.product}', 'sku': '#{item.sku}', 'category': '#{item.category}', 'price': '#{item.price}', 'quantity': '#{item.quantity}'});\n"
        end.join('\n')
        conf << "ga('ecommerce:send');\n"
        @transaction = nil
        conf
      end

      def custom_vars
        @custom_vars ||= {}
      end
    end

    class Item < Struct.new(:sku, :product, :category, :price, :quantity)
    end

    class Transaction < Struct.new(:id, :store, :total, :tax, :shipping, :city, :state, :country)
      def add_item(sku, product, category, price, quantity)
        items << Item.new(sku, product, category, price, quantity)
      end

      def items
        @items ||= []
      end
    end
  end
end



