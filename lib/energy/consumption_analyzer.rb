# frozen_string_literal: true
require "csv"

Outlier = Struct.new(:office, :consumption, :deviation)

class ConsumptionAnalyzer
    def initialize

    end

    CONSUMPTIONS_A_YEAR = 12

    def execute(file_name, deviation_factor = 1.4)
        data = obtain_readings(file_name)
        offices = offices(data)
        outliers = outliers(deviation_factor, offices)
        puts outliers
        puts "Data sample #{data.size} rows"
        puts "Found #{outliers.size} outliers"
        puts "Found #{outliers.size / 300} per office"
    end

    def outliers(deviation_factor, offices)
        outliers = []
        offices.each do |officeId, consumptions|
            average = average(consumptions)
            standard_deviation = standard_deviation(consumptions)

            consumptions.each do |consumption|
                difference = (consumption - average).abs
                boundary = standard_deviation * deviation_factor

                next unless difference > boundary

                outlier = Outlier.new
                outlier.office = officeId.split('-')[0].to_i
                outlier.consumption = consumption
                outlier.deviation = (consumption - average) / standard_deviation

                outliers.append(outlier)
            end
        end
        outliers
    end

    def offices(data)
        offices = {}
        consumptions = []
        data.each do |row|
            consumptions.append(row["consumption"])

            next if consumptions.size < CONSUMPTIONS_A_YEAR

            officeId = "#{row["office"]}-#{row["year"]}"
            offices[officeId] = consumptions
            consumptions = []
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
