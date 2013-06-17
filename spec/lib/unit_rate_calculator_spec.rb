require_relative '../spec_helper.rb'

describe "The Unit Rate Calculator" do
  let (:unit) { :unit }
  let (:reservation_range) { :reservation_range }
  let (:tax_rate) { :tax_rate }

  it "can be instantiated" do
    UnitRateCalculator.new(unit, reservation_range, tax_rate).should_not be_nil
  end

  # TODO: These tests don't smell right.  They contain a lot of carnal knowledge.
  describe "when calculating rates" do
    describe "base rate calculation" do
      describe "when all dates are in a single season" do
        let (:rate) { 7.0 }
        let (:cleaning_fee) { 5.0 }
        let (:num_days) { 2 }

        it "returns ((rate) x (number of days)) + cleaning fee" do
          season = Object.new
          season.stub(:rate) { rate }
          season.stub(:contains) { true }

          unit = Object.new
          unit.stub(:seasons) { [season] }
          unit.stub(:cleaning_fee) { cleaning_fee }

          res_range = Date.today.upto(Date.today + num_days)

          unit_rate_calculator = UnitRateCalculator.new(unit, res_range, tax_rate)
          unit_rate_calculator.base_rate.should == (rate * num_days) + cleaning_fee
        end
      end

      describe "when dates cross seasons" do
        it "works correctly" do
          res_range = Date.today.upto(Date.today + 3)
          first_day = res_range.to_a[0]
          second_day = res_range.to_a[1]
          third_day = res_range.to_a[2]

          rate0 = 1
          season0 = Object.new
          season0.stub(:rate) { rate0 }
          season0.stub(:contains) do |arg|
            arg == first_day
          end

          rate1 = 3
          season1 = Object.new
          season1.stub(:rate) { rate1 }
          season1.stub(:contains) do |arg|
            arg == second_day
          end

          rate2 = 5
          season2 = Object.new
          season2.stub(:rate) { rate2 }
          season2.stub(:contains) do |arg|
            arg == third_day
          end

          unit = Object.new
          unit.stub(:seasons) { [season0, season1, season2] }
          unit.stub(:cleaning_fee) { 0 }

          unit_rate_calculator = UnitRateCalculator.new(unit, res_range, tax_rate)
          unit_rate_calculator.base_rate.should == rate0 + rate1 + rate2
        end
      end
    end

    it "multiplies the base rate by the tax rate" do
      tax_rate = 2.0
      base_rate = 5.0
      unit_rate_calculator = UnitRateCalculator.new(:unit, :res_range, tax_rate)

      unit_rate_calculator.stub(:base_rate) { base_rate }

      unit_rate_calculator.calculate.should == tax_rate * base_rate;
    end
  end
end
