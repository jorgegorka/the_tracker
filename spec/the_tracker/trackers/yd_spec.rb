require 'spec_helper'

describe TheTracker::Trackers::Yd do
  subject { described_class.new(id: 12345678, product: '9876543', order_id: '2', cookies_allowed: 1) }
  describe :methods do
    describe :body_bottom do
      it 'should return ad_form content' do
        subject.body_bottom.should include('https://d.254a.com')
      end

      it 'should include id, seg and orderID' do
        subject.body_bottom.should include("id=12345678");
        subject.body_bottom.should include("product=9876543");
        subject.body_bottom.should include("orderid=2");
        subject.body_bottom.should include("cookies_allowed=1");
      end

      it 'returns nothing if tracker not active' do
        subject.active = false
        subject.body_bottom.should == nil
      end
    end

    describe :cookiesAllowed do
      context 'when cookiesAllowed is not set in the params' do
        before :each do
          @yd_tracker = described_class.new(id: 12345678, product: '9876543', order_id: '2')
        end

        it 'should be 1' do
          @yd_tracker.body_bottom.should include("cookies_allowed=1");
        end
      end
    end
  end
end
