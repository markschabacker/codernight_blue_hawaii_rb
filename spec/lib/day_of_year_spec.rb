require_relative '../spec_helper.rb'

describe "Day of Year" do
  before do
    @day = :day
    @month = :month

    @day_of_year = DayOfYear.new(@month, @day)
  end

  subject { @day_of_year }

  it { should respond_to(:month) }
  it { should respond_to(:day) }

  it { should_not respond_to(:month=) }
  it { should_not respond_to(:day=) }

  it "can be instantiated" do
    DayOfYear.new(@month, @day).should_not be_nil
  end

  it "sets properties in constructor" do
    day = DayOfYear.new(@month, @day)

    day.month.should == @month
    day.day.should == @day
  end

  it "defines the first day of the year" do
    first_day = DayOfYear.first_day
    first_day.month.should == 1
    first_day.day.should == 1
  end

  it "defines the last day of the year" do
    last_day = DayOfYear.last_day
    last_day.month.should == 12
    last_day.day.should == 31
  end
end