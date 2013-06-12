require_relative '../spec_helper.rb'

describe "Season" do
  before do
    @start_day = :start_day
    @start_month = :start_month
    @end_day = :end_day
    @end_month = :end_month
    @rate = :rate

    @season = Season.new(@start_day, @start_month, @end_day, @end_month, @rate)
  end

  subject { @season }

  it {should respond_to(:start_day) }
  it {should_not respond_to(:start_day=) }

  it {should respond_to(:start_month) }
  it {should_not respond_to(:start_month=) }

  it {should respond_to(:end_day) }
  it {should_not respond_to(:end_day=) }

  it {should respond_to(:end_month) }
  it {should_not respond_to(:end_month=) }

  it {should respond_to(:rate) }
  it {should_not respond_to(:rate=) }

  it "can be instantiated" do
    Season.new(@start_month, @start_day, @end_month, @end_day, @rate)
  end

  it "can be instantiated and set property values" do
    @season = Season.new(@start_month, @start_day, @end_month, @end_day, @rate)

    @season.start_day.should == @start_day
    @season.start_month.should == @start_month
    @season.end_day.should == @end_day
    @season.end_month.should == @end_month
    @season.rate.should == @rate
  end
end
