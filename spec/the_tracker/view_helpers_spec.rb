require 'spec_helper'

class GAnalitics < TheTracker::Trackers::Base
  def header
    'header tracking code'
  end

  def body_top
    'body top tracking code'
  end

  def body_bottom
    'body bottom tracking code'
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
      @vc.header_tracking_code.should == 'header tracking code'
    end
  end

  describe 'Body Top' do
    it 'display top info' do
      @vc.body_top_tracking_code.should == 'body top tracking code'
    end
  end

  describe 'Body Bottom' do
    it 'display bottom info' do
      @vc.body_bottom_tracking_code.should == 'body bottom tracking code'
    end
  end
end
