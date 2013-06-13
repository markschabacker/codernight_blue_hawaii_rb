require 'rspec'

require File.join(File.dirname(__FILE__), '../rate_calculator.rb')

RSpec::Matchers.define :equal_season do |expected|
  match do |actual|
    # TODO: just override equality operator?
    actual.start_day_of_year.day.should == expected.start_day_of_year.day
    actual.start_day_of_year.month.should == expected.start_day_of_year.month
    actual.end_day_of_year.day.should == expected.end_day_of_year.day
    actual.end_day_of_year.month.should == expected.end_day_of_year.month
    actual.rate.should == expected.rate
  end
end

RSpec::Matchers.define :be_a_full_year do
  match do |actual|
    actual.start_day_of_year.day.should == 1
    actual.start_day_of_year.month.should == 1
    actual.end_day_of_year.day.should == 31
    actual.end_day_of_year.month.should == 12
  end
end
