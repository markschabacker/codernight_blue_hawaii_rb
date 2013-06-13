require_relative '../spec_helper.rb'

describe "Season" do
  before do
    @start_day_of_year = :start_day_of_year
    @end_day_of_year = :end_day_of_year
    @rate = :rate

    @season = Season.new(@start_day_of_year, @end_day_of_year, @rate)
  end

  subject { @season }

  it {should respond_to(:start_day_of_year) }
  it {should_not respond_to(:start_day_of_year=) }

  it {should respond_to(:end_day_of_year) }
  it {should_not respond_to(:end_day_of_year=) }

  it {should respond_to(:rate) }
  it {should_not respond_to(:rate=) }

  it "can be instantiated" do
    Season.new(@start_day_of_year, @end_day_of_year, @rate).should_not be_nil
  end

  it "can be instantiated and set property values" do
    @season = Season.new(@start_day_of_year, @end_day_of_year, @rate)

    @season.start_day_of_year.should == @start_day_of_year
    @season.end_day_of_year.should == @end_day_of_year
    @season.rate.should == @rate
  end
end
