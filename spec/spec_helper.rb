require 'rspec'

require File.join(File.dirname(__FILE__), '../rate_calculator.rb')

RSpec::Matchers.define :be_a_full_year do
  match do |actual|
    actual.start_day.should == 1
    actual.start_month.should == 1
    actual.end_day.should == 31
    actual.end_month.should == 12
  end
end
