require 'rspec'

require File.join(File.dirname(__FILE__), '../rate_calculator.rb')

RSpec::Matchers.define :equal_season do |expected|
  match do |actual|
    # TODO: just override equality operator?
    actual.start_day.should == expected.start_day
    actual.start_month.should == expected.start_month
    actual.end_day.should == expected.end_day
    actual.end_month.should == expected.end_month
    actual.rate.should == expected.rate
  end
end

RSpec::Matchers.define :be_a_full_year do
  match do |actual|
    actual.start_day.should == 1
    actual.start_month.should == 1
    actual.end_day.should == 31
    actual.end_month.should == 12
  end
end
