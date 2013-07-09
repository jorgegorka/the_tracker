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

    describe :add_once do
      before :each do
        test_tr = mock('Object', :body_bottom => 'my tracker', :name => :track_test)
        described_class.reset
        described_class.config do |tmf|
          tmf.add test_tr
        end
        test_tr2 = mock('Object', :body_bottom => 'other tracker', :name => :track_test2)
        described_class.instance.add_once test_tr2
      end

      it 'register a new tracker' do
        described_class.instance.trackers.size.should == 2
      end

      it 'deregister the tracker after it has been injected on a page' do
        described_class.instance.trackers.size.should == 2
        described_class.instance.body_bottom
        described_class.instance.trackers.size.should == 1
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
        @tracker.header.should == "google analytics\nsite catalist"
      end

      it 'should not render nil trackers' do
        ss = mock('Object', :header => 'site nil', :name => :stupid_site)
        ss.stub(:header).and_return(nil)
        @tracker.add ss
        @tracker.header.should == 'google analytics'
      end
    end

    describe :body_top do
      before :each do
        ga = mock('Object', :body_top => 'google analytics', :name => :ganalytics)
        tracker = TheTracker::Tracker.clone
        @tracker = tracker.instance
        @tracker.add ga
      end

      it 'returns body_top from trackers' do
        @tracker.body_top.should == 'google analytics'
      end

      it 'adds new tracker' do
        sc = mock('Object', :body_top => 'site catalist', :name => :sitecat)
        sc.stub(:body_top).and_return('site catalist')
        @tracker.add sc
        @tracker.body_top.should == "google analytics\nsite catalist"
      end

      it 'should not render nil trackers' do
        ss = mock('Object', :body_top => 'site nil', :name => :stupid_site)
        ss.stub(:body_top).and_return(nil)
        @tracker.add ss
        @tracker.body_top.should == 'google analytics'
      end
    end

    describe :body_bottom do
      before :each do
        ga = mock('Object', :body_bottom => 'google analytics', :name => :ganalytics)
        tracker = TheTracker::Tracker.clone
        @tracker = tracker.instance
        @tracker.add ga
      end

      it 'returns body_bottom from trackers' do
        @tracker.body_bottom.should == 'google analytics'
      end

      it 'adds new tracker' do
        sc = mock('Object', :body_bottom => 'site catalist', :name => :sitecat)
        sc.stub(:body_bottom).and_return('site catalist')
        @tracker.add sc
        @tracker.body_bottom.should == "google analytics\nsite catalist"
      end

      it 'should not render nil trackers' do
        ss = mock('Object', :body_bottom => 'site nil', :name => :stupid_site)
        ss.stub(:body_bottom).and_return(nil)
        @tracker.add ss
        @tracker.body_bottom.should == 'google analytics'
      end
    end
  end
end
