require 'spec_helper'

describe TheTracker::Trackers::GAdServices do
  subject { described_class.new(:id => 12345678, :language => 'en', :format => '2', :color => "ffffff", :label => 'SomeThingReallyCool', :value => 0) }
  describe :methods do
    describe :header do
      it 'should return ad_form content' do
        subject.header.should include('//www.googleadservices.com/pagead/conversion.js')
      end

      it 'should include id, langage, format, color, label and value information' do
        subject.header.should include('var google_conversion_id = 12345678');
        subject.header.should include("var google_conversion_language = \"en\"");
        subject.header.should include("var google_conversion_format = \"2\"");
        subject.header.should include("var google_conversion_color = \"ffffff\"");
        subject.header.should include("var google_conversion_label = \"SomeThingReallyCool\"");
        subject.header.should include('var google_conversion_value = 0');
      end

      it 'returns nothing if tracker not active' do
        subject.active = false
        subject.header.should == nil
      end
    end
  end
end
