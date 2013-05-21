require 'spec_helper'

describe TheTracker::Trackers::Base do
  describe :methods do
    describe :header do
      it 'should return an empty array' do
         subject.header.should == []
      end
    end

    describe :body_top do
      it 'should return an empty array' do
         subject.body_top.should == []
      end
    end

    describe :body_bottom do
      it 'should return an empty array' do
         subject.body_bottom.should == []
      end
    end

    describe :name do
      it 'should raise a NotImplementedError' do
        expect { subject.name }.to raise_error(NotImplementedError)
      end
    end

    describe :active do
      it 'should be active by default' do
        subject.active.should be
      end

      it 'should be active by default' do
        subject.active = false
        subject.active.should be_false
      end
    end
  end
end
