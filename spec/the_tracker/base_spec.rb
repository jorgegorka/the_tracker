require 'spec_helper'

describe TheTracker::Base do
  describe :methods do
    describe :header do
      it 'should raise a NotImplementedError' do
        expect { subject.header }.to raise_error(NotImplementedError)
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
