# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/energy/json_consumptions_provider'

RSpec.describe JsonConsumptionsProvider do
    it "should read all records in file" do
        provider = JsonConsumptionsProvider.new
        consumptions = provider.from_file("example.json")
        expect(consumptions.size).to eq(12)
    end

    it "should read data in first record" do
        provider = JsonConsumptionsProvider.new
        consumptions = provider.from_file("example.json")
        expected = Consumption.new
        expected.office = 1
        expected.year = 2023
        expected.month = 1
        expected.consumption = 8379097

        expect(consumptions[0]).to eq(expected)
    end

    it "should read data in last record" do
        provider = JsonConsumptionsProvider.new
        consumptions = provider.from_file("example.json")
        expected = Consumption.new
        expected.office = 1
        expected.year = 2023
        expected.month = 12
        expected.consumption = 2062790

        expect(consumptions[11]).to eq(expected)
    end
end
