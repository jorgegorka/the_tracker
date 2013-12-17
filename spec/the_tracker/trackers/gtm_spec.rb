require 'spec_helper'

describe TheTracker::Trackers::Gtm do
  subject { described_class.new(:gtmid => 'GTM-XXXXX') }
  describe :methods do
    describe :body_top do
      it 'should return gtm content' do
        subject.body_top.should include('<iframe src="//www.googletagmanager.com/ns.html?id=')
      end

      it 'should include id, langage, format, color, label and value information' do
        subject.body_top.should include("id=GTM-XXXXX");
      end

      it 'returns nothing if tracker not active' do
        subject.active = false
        subject.body_top.should == nil
      end
    end
  end
end
