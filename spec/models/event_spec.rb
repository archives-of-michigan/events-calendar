require 'spec_helper'
require 'time'

describe Event do
  describe '.in_category' do
    it 'should show all events in a given category' do
      cata = Category.create :name => 'a'
      catb = Category.create :name => 'b'
      Event.create! :category => cata, :start => Time.now + 10
      Event.create! :category => cata, :start => Time.now + 10
      Event.create! :category => catb, :start => Time.now + 10

      Event.in_category('a').count.should == 2
    end
  end

  describe 'time' do
    it 'should display a time for a single-day event with a start/end that is not all day' do
      event = Event.new :start => Time.parse('2010-08-01 10:00:00'),
                        :end   => Time.parse('2010-08-01 18:00:00')
      event.time.should == 'From 10:00AM to 06:00PM'
    end
    it 'should display a time for a multi-day event' do
      event = Event.new :start => Time.parse('2010-08-01 10:00:00'),
                        :end   => Time.parse('2010-08-11 18:00:00')
      event.time.should == 'From August 01, 2010 to August 11, 2010'
    end
    it 'should display "All day" for an all day event' do
      event = Event.new :start => Time.parse('2010-08-01 10:00:00'), :all_day => true
      event.time.should == 'All day'
    end
    it 'should display the time in am/pm format for a single day event' do
      event = Event.new :start => Time.parse('2010-08-01 10:00:00')
      event.time.should == '10:00AM'
    end
  end

  describe 'url' do
    it 'should return the user-entered website if given' do
      event = Event.new :website => 'http://gomer.com'
      event.url.should == 'http://gomer.com'
    end
    it 'should return the event url if no website given' do
      event = Event.new
      event.should_receive :event_url
      event.url
    end
  end

  describe '.to_json' do
    let(:event) { Event.create :name => 'Event of the season', :location => 'Venue of the town' }
    let(:json_object) { event.to_json }

    it 'should return some json'
  end
end