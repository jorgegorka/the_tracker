require 'spec_helper'

describe TheTracker::Trackers::Smart4Ads do
  subject { described_class.new(scriptId: 12345678, accountId: '9876543', totalCost: '0.00', orderId: 'PPEE44', actionCode: 'XX0099') }
  describe :methods do
    describe :body_bottom do
      it 'should return ad_form content' do
        subject.body_bottom.should include('://www.smart4ads.com/smart4ads/api/PVTjs.php')
      end

      it 'should include id, seg and orderID' do
        subject.body_bottom.should include("script id=\"12345678\"");
        subject.body_bottom.should include("accountid=9876543");
        subject.body_bottom.should include("totalcost=0.00");
        subject.body_bottom.should include("orderid=PPEE44");
        subject.body_bottom.should include("actioncode=XX0099");
      end

      it 'returns nothing if tracker not active' do
        subject.active = false
        subject.body_bottom.should == nil
      end
    end
  end
end