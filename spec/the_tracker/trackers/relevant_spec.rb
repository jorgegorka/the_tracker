require 'spec_helper'

describe TheTracker::Trackers::Relevant do
  subject { described_class.new(:token => 12345678, :seg => '9876543', :orderId => '2') }
  describe :methods do
    describe :body_bottom do
      it 'should return ad_form content' do
        subject.body_bottom.should include('://ib.adnxs.com/px')
      end

      it 'should include id, seg and orderID' do
        subject.body_bottom.should include("id=12345678");
        subject.body_bottom.should include("seg=9876543");
        subject.body_bottom.should include("orderId=2");
      end

      it 'returns nothing if tracker not active' do
        subject.active = false
        subject.body_bottom.should == nil
      end
    end
  end
end
