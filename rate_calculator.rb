require 'JSON'

class RateCalculator
  def calculate_rates(units_json_string, reservation_string, tax_rate)
    unit_hydrator = UnitHydrator.new
    units = unit_hydrator.hydrate_json(units_json_string)

    reservation_range_generator = ReservationRangeGenerator.new
    reservation_range = reservation_range_generator.generate_date_range(reservation_string)

    unit_rates = {}
    units.each do |unit|
      unit_rate_calculator = UnitRateCalculator.new(unit, reservation_range, tax_rate)
      unit_rates[unit.name] = unit_rate_calculator.calculate_rate
    end
    unit_rates
  end
end

class UnitHydrator
end

class Unit
  attr_reader :name, :seasons, :cleaning_fee

  def initialize(name, seasons, cleaning_fee)
    @name = name
    @seasons = seasons
    @cleaning_fee = cleaning_fee
  end
end

class Season
  # TODO: encapsulate day/month pair?
  # TODO: enforce that start is before end?
  attr_reader :start_day, :start_month, :end_day, :end_month, :rate

  def initialize(start_month, start_day, end_month, end_day, rate)
    @start_day = start_day
    @start_month = start_month
    @end_day = end_day
    @end_month = end_month
    @rate = rate
  end

end

class ReservationRangeGenerator
end

class UnitRateCalculator
end
