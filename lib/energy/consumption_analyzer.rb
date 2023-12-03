# frozen_string_literal: true
require "csv"
require_relative 'csv_consumptions_provider'
require_relative 'consumptions_provider'

Outlier = Struct.new(:office, :consumption, :deviation)

Consumption = Struct.new(:office, :year, :month, :consumption)

class ConsumptionAnalyzer
    def initialize(provider = ConsumptionsProvider.new)
        @provider = provider
    end

    CONSUMPTIONS_A_YEAR = 12

    def execute(deviation_factor, *files)
        normalized = @provider.from_file(*files)
        offices = offices(normalized)
        outliers = outliers(deviation_factor, offices)

        puts outliers
        puts "Data sample #{normalized.size} rows"
        puts "Found #{outliers.size} outliers"
        puts "Found #{outliers.size / offices.size} per office"
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
                outlier.office = office_id
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
            offices[office_id] = [] unless offices.key? office_id
            offices[office_id].append(row.consumption)
        end
        offices
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
