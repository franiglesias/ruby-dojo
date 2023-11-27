# frozen_string_literal: true
require "csv"
ConsumptionRow = Struct.new(:office, :year, :month, :consumption)

class DataGenerator
  def initialize(offices, years, file_name)
    @offices = offices
    @years = years
    @file_name = file_name
  end

  def generate
    data = []

    starting_year = 2023 - @years + 1

    (1..@offices).each do |office|
      max_consumption = [999_999, 9_999_999, 99_999_999].sample
      (starting_year..2023).each do |year_number|
        (1..12).each do |month|
          row = ConsumptionRow.new
          row.office = office
          row.year = year_number
          row.month = month
          row.consumption = rand(1000..max_consumption)
          data.append(row)
        end
      end
    end

    # films_info is an array of CSV objects
    headers = ['office', 'year', 'month', 'consumption']
    CSV.open(@file_name, "w") do |csv|
      csv << headers
      data.each do |row|
        csv << row
      end
    end
  end
end



g = DataGenerator.new(300, 5, "sample.csv")
g.generate
