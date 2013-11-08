require 'spec_helper'

describe TheTracker::Trackers::Kenshoo do
  subject { described_class.new(:token => 12345678, :type => 'en', :val => '2', :orderId => "ffffff", :promoCode => 'SomeThingReallyCool', :valueCurrency => 'EUR', trackEvent: '6969') }
  describe :methods do
    describe :body_bottom do
      it 'should return ad_form content' do
        subject.body_top.should include('://6969.xg4ken.com/media/getpx.php')
      end

      it 'should include id, langage, format, color, label and value information' do
        subject.body_top.should include("params[0]='id=12345678'");
        subject.body_top.should include("params[1]='type=en'");
        subject.body_top.should include("params[2]='val=2'");
        subject.body_top.should include("params[3]='orderId=ffffff'");
        subject.body_top.should include("params[4]='promoCode=SomeThingReallyCool'");
        subject.body_top.should include("params[5]='valueCurrency=EUR'");
        subject.body_top.should include("k_trackevent(params,'6969'");
      end

      it 'returns nothing if tracker not active' do
        subject.active = false
        subject.body_top.should == nil
      end
    end
  end
end
