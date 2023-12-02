# frozen_string_literal: true
require 'json'
require_relative 'consumption_analyzer'

class JsonConsumptionProvider
    def from_file(filename)
        f = File.new(filename, "r")
        raw = f.read
        data = JSON.parse(raw)
        f.close

        consumptions = []

        data.each do |h|
            c = Consumption.new
            c.office = h["office"]
            c.year = h["year"]
            c.month = h["month"]
            c.consumption = h["consumption"]
            consumptions.append(c)
        end
        consumptions
    end
end
