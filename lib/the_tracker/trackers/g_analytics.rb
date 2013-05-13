module TheTracker
  module Trackers
    class GAnalytics < Base

      # Analytics uat
      def initialize(options)
        @options = options
        super()
      end

      def name
        :ganalytics
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

      def header
        return if !active
        <<-EOF
        <script type="text/javascript">//<![CDATA[
        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', '#{@options[:id]}']);
        #{extra_conf}
        _gaq.push(['_trackPageview']);
        (function () {
        var ga = document.createElement('script');
        ga.type = 'text/javascript';
        ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0];
        s.parentNode.insertBefore(ga, s);
        })();
        //]]></script>
        EOF
      end

      private

      def extra_conf
        conf = ''
        conf << "_gaq.push(['_setDomainName', '#{@options[:domain_name]}']);\n" if @options[:domain_name]
        conf << "_gaq.push(['_setAllowLinker', #{@options[:allow_linker]}]);\n" if @options[:allow_linker]
        conf << set_custom_vars
        conf << set_transactions
        conf
      end

      def set_custom_vars
        custom_vars.map do | index, cv |
          "_gaq.push(['_setCustomVar', '#{index}', '#{cv[0]}', '#{cv[1]}', '#{cv[2]}']);"
        end.join('\n')
      end

      def set_transactions
        return '' unless @transaction
        conf = "_gaq.push(['_addTrans', '#{@transaction.id}', '#{@transaction.store}', '#{@transaction.total}', '#{@transaction.tax}', '#{@transaction.shipping}', '#{@transaction.city}', '#{@transaction.state}', '#{@transaction.country}']);\n"
        conf << @transaction.items.map do |item|
          "_gaq.push(['_addItem', '#{@transaction.id}', '#{item.sku}', '#{item.product}', '#{item.category}', '#{item.price}', '#{item.quantity}']);"
        end.join('\n')
        conf << "_gaq.push(['_trackTrans']);"
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
