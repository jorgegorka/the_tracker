require 'spec_helper'

describe TheTracker::Trackers::GAnalytics do
 subject { described_class.new(:id => 'UA-111-11') }

  describe :initialize do
    before :each do
      @ga = described_class.new(
        id: 111,
        domain_name: 'test.com',
        allow_linker: true
      )
    end

    it 'should return domain name content' do
      @ga.header.should include("_gaq.push(['_setDomainName', 'test.com']);")
    end

    it 'should return allow linker name content' do
      @ga.header.should include("_gaq.push(['_setAllowLinker', true]);")
    end
  end

  describe :methods do
    describe :add_custom_var do
      it 'should add a custom var' do
        subject.add_custom_var(1, 'user', '111', 1)
        subject.header.should include("_gaq.push(['_setCustomVar', '1', 'user', '111', '1']);")
      end
    end

    describe :transactions do
      before :each do
        subject.add_transaction('1234', 'Acme Clothing', '11.99', '1.29', '5', 'San Jose', 'California', 'USA')
        subject.add_transaction_item('DD44', 'T-Shirt', 'Green Medium', '11.99', '1')
      end

      describe :add_transaction do
        it 'should add the transaction tag' do
          subject.header.should include("_gaq.push(['_addTrans'")
        end
      end

      describe :add_transaction_item do
        it 'should add the transaction_item tag' do
          subject.header.should include("_gaq.push(['_addItem'")
        end
      end

      it 'should add the tracker of the transaction' do
        subject.header.should include("_gaq.push(['_trackTrans']);")
      end

      context 'if transaction id is nil' do
        before :each do
          @default = described_class.new(:id => 'UA-111-11')
        end

        it 'should add default timestamp as transaction id when zero' do
          @default.add_transaction(0, 'Acme Clothing', '11.99', '1.29', '5', 'San Jose', 'California', 'USA')
          @default.header.should =~ /_gaq.push\(\['_addTrans', '\d{2,}'/
        end

        it 'should add default timestamp as transaction id when nil' do
          @default.add_transaction(nil, 'Acme Clothing', '11.99', '1.29', '5', 'San Jose', 'California', 'USA')
          @default.header.should =~ /_gaq.push\(\['_addTrans', '\d{2,}'/
        end
      end
    end

    describe :header do
      it 'should return analytics content' do
        subject.header.should include("_gaq.push(['_trackPageview']);")
      end

      it 'should include ua information' do
        subject.header.should include("_gaq.push(['_setAccount', 'UA-111-11']);")
      end
    end

    describe :name do
      it 'should return ganalytics' do
        subject.name.should == :ganalytics
      end
    end
  end
end
