require 'spec_helper'

class GAnalitics < TheTracker::Trackers::Base
  def header
    'some tracking code'
  end

  def name
    :ganalytics
  end
end

class ViewClass
  include TheTracker::ViewHelpers
end

describe 'View Helpers' do
  before :each do
    TheTracker::Tracker.reset
    TheTracker::Tracker.config do |tmf|
      tmf.add GAnalitics.new
    end
    @vc = ViewClass.new
  end

  describe 'Header' do
    it 'display header info' do
      @vc.header_tracking_code.should == 'some tracking code'
    end
  end
end
