require 'spec_helper'

describe TheTracker::Tracker do
  describe :methods do
    describe :add do
      it 'returns registered trackers' do
        test_tr = mock('Object', :header => 'my tracker', :name => :track_test)
        described_class.reset
        described_class.config do |tmf|
          tmf.add test_tr
        end
        test_tr2 = mock('Object', :header => 'other tracker', :name => :track_test2)
        described_class.instance.add test_tr2
        described_class.instance.trackers.size.should == 2
      end
    end

    describe :header do
      before :each do
        ga = mock('Object', :header => 'google analytics', :name => :ganalytics)
        tracker = TheTracker::Tracker.clone
        @tracker = tracker.instance
        @tracker.add ga
      end

      it 'returns all headers from trackers' do
        @tracker.header.should == 'google analytics'
      end

      it 'adds headers of new tracker' do
        sc = mock('Object', :header => 'site catalist', :name => :sitecat)
        sc.stub(:header).and_return('site catalist')
        @tracker.add sc
        @tracker.header.should == 'google analytics\nsite catalist'
      end
    end
  end
end
