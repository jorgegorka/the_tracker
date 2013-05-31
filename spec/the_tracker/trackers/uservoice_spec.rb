require 'spec_helper'

describe TheTracker::Trackers::Uservoice do
  subject { described_class.new('abcd', {:forum_id => '111', :tab_label => 'Say Hi!'}) }
  describe :methods do
    describe :header do
      it 'should return uservoice script' do
        subject.header.should include('widget.uservoice.com/abcd.js')
      end
    end

    describe :name do
      it 'should return uservoice' do
        subject.name.should == :uservoice
      end
    end

    describe :body_bottom do
      it 'should return uservoice variable' do
        subject.body_bottom.should include('UserVoice = window.UserVoice')
      end

      it 'should include forum_id and tab_label information' do
        subject.body_bottom.should include('"forum_id":"111"')
        subject.body_bottom.should include('"tab_label":"Say Hi!"')
      end
    end
  end
end
