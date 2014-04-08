require 'spec_helper'

describe TheTracker::Trackers::GUniversal do
 subject { described_class.new(:id => 'UA-111-11') }

  describe :initialize do
    before :each do
      @ga = described_class.new(
        id: 'UA-111-22',
        domain_name: ['source.com', 'destination.com'],
        allow_linker: true
      )
    end

    it 'should return allow linker name content' do
      @ga.header.should include("ga('create', 'UA-111-22', 'auto', {'name': 'guniversal', 'allowLinker': true});")
    end

    it 'should return require linker' do
      @ga.header.should include("ga('guniversal.require', 'linker');")
    end

    it 'should include all domains in autolink' do
      @ga.header.should include("ga('linker:autoLink', [\"source.com\", \"destination.com\"]);")
    end
  end

    it 'should return User Id' do
      subject.add_custom_var(:metric, 1, 999.99)
    end

  describe :methods do
    describe :add_custom_dimension do
      it 'should add a custom dimension' do
        subject.add_custom_var(:dimension, 1, 'user')
        subject.header.should include("ga('guniversal.set', 'dimension1', 'user');")
      end
    end

    describe :add_custom_metric do
      it 'should add a custom metric' do
        subject.add_custom_var(:metric, 1, 999.99)
        subject.header.should include("ga('guniversal.set', 'metric1', '999.99');")
      end
    end

    describe :transactions do
      before :each do
        subject.add_transaction('1234', 'Acme Clothing', '11.99', '1.29', '5')
        subject.add_transaction_item('DD44', 'T-Shirt', 'Green Medium', '11.99', '1')
      end

      it 'should add transaction library' do
        subject.header.should include("ga('guniversal.require', 'ecommerce', 'ecommerce.js');")
      end

      describe :add_transaction do
        it 'should add the transaction tag' do
          subject.header.should include("ga('guniversal.ecommerce:addTransaction'")
        end

        it 'should add the transaction tag but only once' do
          subject.header
          subject.header.should_not include("ga('guniversal.ecommerce:addTransaction'")
        end
      end

      describe :add_transaction_item do
        it 'should add the transaction_item tag' do
          subject.header.should include("ga('guniversal.ecommerce:addItem', {")
        end
      end

      it 'should add the tracker of the transaction' do
        subject.header.should include("ga('guniversal.ecommerce:send');")
      end

      context 'if transaction id is nil' do
        before :each do
          @default = described_class.new(:id => 'UA-111-11', :name => :second_tracker)
        end

        it 'should add default timestamp as transaction id when zero' do
          @default.add_transaction(0, 'Acme Clothing', '11.99', '1.29', '5')
          @default.header.should =~ /ga\('second_tracker.ecommerce:addTransaction', { 'id': '\d{2,}'/
        end

        it 'should add default timestamp as transaction id when nil' do
          @default.add_transaction(nil, 'Acme Clothing', '11.99', '1.29', '5')
          @default.header.should =~ /ga\('second_tracker.ecommerce:addTransaction', { 'id': '\d{2,}'/
        end
      end

      describe :add_user_id do
        it 'should return User Id' do
          subject.add_user_id('abcde123456')
          subject.header.should include("ga('create', 'UA-111-11', 'auto', {'name': 'guniversal', 'userId': 'abcde123456'});")
        end
      end
    end

    describe :header do
      it 'should return analytics content' do
        subject.header.should include("ga('guniversal.send', 'pageview');")
      end

      it 'should include UA information' do
        subject.header.should include("ga('create', 'UA-111-11', 'auto', {'name': 'guniversal'});")
      end

      it 'should not include linker information by default' do
        subject.header.should_not include("ga('create', 'UA-111-11', 'auto', {'allowLinker': true});")
      end
    end

    describe :name do
      context 'when name is set in options' do
        before :each do
          @universal =  described_class.new(id: 'UA-111-11', name: 'test_track')
        end
        it 'should name the instance as name' do
          @universal.name.should == 'test_track'
        end

        it 'should track pageviews namespaced' do
          @universal.header.should include("ga('test_track.send', 'pageview');")
        end
      end

      context 'when no name is provided' do
        it 'should return ganalytics' do
          subject.name.should == :guniversal
        end

        it 'should track pageviews namespaced' do
          subject.header.should include("ga('guniversal.send', 'pageview');")
        end
      end
    end
  end
end
