require 'spec_helper'

describe TheTracker::Tracker do
  describe :methods do
    describe :add do
      it 'returns registered trackers' do
        described_class.reset
        described_class.config do |tmf|
          tmf.add 'my tracker'
        end
        described_class.instance.add 'other tracker'
        described_class.instance.trackers.size.should == 2
      end
    end

    describe :header do
      before :each do
        ga = mock('Object')
        ga.stub(:header).and_return('google analytics')
        tracker = TheTracker::Tracker.clone
        @tracker = tracker.instance
        @tracker.add ga
      end

      it 'returns all headers from trackers' do
        @tracker.header.should == 'google analytics'
      end

      it 'adds headers of new tracker' do
        sc = mock('Object')
        sc.stub(:header).and_return('site catalist')
        @tracker.add sc
        @tracker.header.should == 'google analytics\nsite catalist'
      end
    end
  end
end
