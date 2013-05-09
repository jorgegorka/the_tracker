require 'spec_helper'

describe TheTracker::Trackers::Uservoice do
  subject { described_class.new(:forum_id => '111', :tab_label => 'Say Hi!') }
  describe :methods do
    describe :header do
      it 'should return uservoice content' do
        subject.header.should include('widget.uservoice.com/')
      end

      it 'should include forum_id and tab_label information' do
        subject.header.should include('"forum_id":"111"')
        subject.header.should include('"tab_label":"Say Hi!"')
      end
    end

    describe :name do
      it 'should return uservoice' do
        subject.name.should == :uservoice
      end
    end
  end
end
