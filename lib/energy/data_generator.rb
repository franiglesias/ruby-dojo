# frozen_string_literal: true
require "csv"
require 'json'

ConsumptionRow = Struct.new(:office, :year, :month, :consumption)

class DataGenerator
  def initialize(offices, years, file_name, starting_office = 1)
    @offices = offices
    @years = years
    @file_name = file_name
    @starting_office = starting_office
  end

  def generate
    data = []

    starting_year = 2023 - @years + 1

    first_office = @starting_office
    last_office = @offices + @starting_office-1
    (first_office..last_office).each do |office|
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

    headers = ['office', 'year', 'month', 'consumption']
    CSV.open("#{@file_name}.csv", "w") do |csv|
      csv << headers
      data.each do |row|
        csv << row
      end
    end


    File.open("#{@file_name}.json","w") do |f|
      all = []
      data.each do |row|
        h = {
          "office": row.office,
          "year": row.year,
          "month": row.month,
          "consumption": row.consumption
        }
        all.append(h)
      end
      f.write(JSON.pretty_generate(all))

      f.close
    end
  end
end



g = DataGenerator.new(150, 1, "sample_2", 301)
g.generate
