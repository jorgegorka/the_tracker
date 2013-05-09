require 'spec_helper'

describe TheTracker::Trackers::AdForm do
  subject { described_class.new(:pm => '111666', :id => '333555') }
  describe :methods do
    describe :header do
      it 'should return ad_form content' do
        subject.header.should include('https://track.adform.net/serving/scripts/trackpoint/async/')
      end

      it 'should include pm and id information' do
        subject.header.should include('pm: 111666')
        subject.header.should include('id: 333555')
      end

      it 'returns nothing if tracker not active' do
        subject.active = false
        subject.header.should == nil
      end
    end
  end
end
