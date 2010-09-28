require 'spec_helper'
require 'time'

describe Event do
  describe '#time' do
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

  describe '#url' do
    it 'should return the user-entered website if given' do
      event = Event.new :website => 'http://gomer.com'
      event.url.should == 'http://gomer.com'
    end
    it 'should return the event url if no website given' do
      event = Event.new
      event.should_receive :website
      event.url
    end
  end

  describe '#to_json' do
    let(:event) { Event.create :name => 'Event of the season', :location => 'Venue of the town' }
    let(:json_object) { event.to_json }

    it 'should return some json'
  end

  describe '#categories' do
    it 'should allow a single category' do
      cat = Category.create!(:name => 'True')
      e = Event.new :name => 'Awesome', :start => '2010-09-13'
      e.categories << cat
      e.save!
      e.categories.count.should == 1
      c = Category.find_by_name 'True'
      c.events.first.should == e
    end
    it 'should allow multiple categories' do
      cat1 = Category.create!(:name => 'True')
      cat2 = Category.create!(:name => 'Yeah')
      e = Event.new :name => 'Awesome', :start => '2010-09-13'
      e.categories << cat1 << cat2
      e.save!
      e.categories.count.should == 2
      c = Category.find_by_name 'True'
      c.events.first.should == e
      c = Category.find_by_name 'Yeah'
      c.events.first.should == e
    end
  end
end
