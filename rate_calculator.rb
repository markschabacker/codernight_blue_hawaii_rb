require 'JSON'
require 'bigdecimal'

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
  def hydrate_json(units_json_string)
    ret_array = []
    return ret_array if units_json_string.nil? || (0 == units_json_string.length)

    unit_dict_array = JSON.parse(units_json_string)
    unit_dict_array.each do |unit_dict|
      name = unit_dict["name"]

      seasons = []

      json_seasons = unit_dict["seasons"]
      unless json_seasons.nil?
        json_seasons.each do |json_season_dict|
          json_season_dict.values.each do |json_season|
            rate = BigDecimal.new(json_season["rate"][1..-1])
            start_month, start_day = json_season["start"].split("-").map { |int_str| int_str.to_i }
            end_month, end_day = json_season["end"].split("-").map { |int_str| int_str.to_i }

            if(end_month < start_month) || ((end_month == start_month) && (end_day < start_day))
              seasons << Season.new(1, 1, end_month, end_day, rate)
              seasons << Season.new(start_month, start_day, 12, 31, rate)
            else
              seasons << Season.new(start_month, start_day, end_month, end_day, rate)
            end
          end
        end
      else
        rate = BigDecimal.new(unit_dict["rate"][1..-1])
        seasons << Season.new(1, 1, 12, 31, rate)
      end

      cleaning_fee_string = unit_dict["cleaning fee"]
      if cleaning_fee_string.nil?
        cleaning_fee = 0
      else
        cleaning_fee = BigDecimal.new(cleaning_fee_string[1..-1])
      end

      ret_array << Unit.new(name, seasons, cleaning_fee)
    end

    ret_array
  end
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

class DayOfYear
  attr_reader :month, :day

  def initialize(month, day)
    @month = month
    @day = day
  end
end

class ReservationRangeGenerator
end

class UnitRateCalculator
end
