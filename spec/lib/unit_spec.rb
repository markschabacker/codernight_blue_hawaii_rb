require_relative '../spec_helper.rb'

describe "A Rental Unit" do
  before do
    @name = :unit_name
    @seasons = :seasons
    @cleaning_fee = :cleaning_fee
    @unit = Unit.new(@name, @seasons, @cleaning_fee)
  end

  subject { @unit }

  it { should respond_to(:name) }
  it { should respond_to(:seasons) }
  it { should respond_to(:cleaning_fee) }

  it { should_not respond_to(:name=) }
  it { should_not respond_to(:seasons=) }
  it { should_not respond_to(:cleaning_fee=) }

  it "can be instantiated" do
    Unit.new(@name, @seasons, @cleaning_fee).should_not be_nil
  end

  it "can be instantiated and set property values" do
    unit = Unit.new(@name, @seasons, @cleaning_fee)

    unit.name.should == @name
    unit.seasons.should == @seasons
    unit.cleaning_fee.should == @cleaning_fee
  end
end
