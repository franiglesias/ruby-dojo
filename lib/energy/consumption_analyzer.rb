# frozen_string_literal: true
require "csv"

Outlier = Struct.new(:office, :consumption, :deviation)

Consumption = Struct.new(:office, :year, :date, :consumption)

class ConsumptionAnalyzer
    def initialize

    end

    CONSUMPTIONS_A_YEAR = 12

    def execute(file_name, deviation_factor = 1.4)
        data = obtain_readings(file_name)
        normalized = normalize(data)
        offices = offices(normalized)
        outliers = outliers(deviation_factor, offices)

        puts outliers
        puts "Data sample #{data.size} rows"
        puts "Found #{outliers.size} outliers"
        puts "Found #{outliers.size / offices.size} per office"
    end

    def normalize(data)
        data.map do |row|
            Consumption.new(row["office"], row["year"], row["month"], row["consumption"])
        end
    end

    def outliers(deviation_factor, offices)
        outliers = []
        offices.each do |office_id, consumptions|
            average = average(consumptions)
            standard_deviation = standard_deviation(consumptions)

            consumptions.each do |consumption|
                difference = (consumption - average).abs
                boundary = standard_deviation * deviation_factor

                next unless difference > boundary

                outlier = Outlier.new
                outlier.office = office_id.split('-')[0].to_i
                outlier.consumption = consumption
                outlier.deviation = (consumption - average) / standard_deviation

                outliers.append(outlier)
            end
        end
        outliers
    end

    def offices(data)
        offices = {}
        data.each do |row|
            office_id = "#{row.office}"
            unless offices.key? office_id
                offices[office_id] = []
            end
            offices[office_id].append(row.consumption)
        end
        offices
    end

    def obtain_readings(file_name)
        CSV.parse(File.read(file_name), headers: true, converters: :numeric)
    end

    def standard_deviation(consumptions)
        Math.sqrt(variance(consumptions))
    end

    def variance(consumptions)
        sum = consumptions.sum(0.0) { |element| (element - average(consumptions)) ** 2 }
        sum / (consumptions.size - 1)
    end

    def average(consumptions)
        consumptions.sum(0.0) / consumptions.size
    end
end
