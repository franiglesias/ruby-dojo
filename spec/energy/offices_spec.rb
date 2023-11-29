# frozen_string_literal: true

require 'rspec'

require_relative '../../lib/energy/consumption_analyzer'

RSpec.describe ConsumptionAnalyzer do
    it "should aggregate same office data" do
        data = [
          Consumption.new(1, 2021, 1, 123456),
        ]

        analyzer = ConsumptionAnalyzer.new
        offices = analyzer.offices(data)
        expect(offices.size).to eq(1)
    end

    it "should identify office by its number" do
        data = [
          Consumption.new(1, 2021, 1, 123456),
        ]

        analyzer = ConsumptionAnalyzer.new
        offices = analyzer.offices(data)
        expect(offices.key? "1").to be_truthy
    end

    it "should separate data from different offices" do
        data = [
          Consumption.new(1, 2021, 1, 123456),
          Consumption.new(2, 2022, 4, 154325),
        ]

        analyzer = ConsumptionAnalyzer.new
        offices = analyzer.offices(data)
        expect(offices.size).to eq(2)
        expect(offices.key? "1").to be_truthy
        expect(offices.key? "2").to be_truthy
    end

    it "should aggregate all data of an office" do
        data = [
          Consumption.new(1, 2021, 1, 123456),
          Consumption.new(2, 2022, 4, 154325),
          Consumption.new(1, 2021, 3, 173412),
          Consumption.new(1, 2021, 7, 109324),
        ]

        analyzer = ConsumptionAnalyzer.new
        offices = analyzer.offices(data)
        expect(offices["1"].size).to eq(3)
        expect(offices["1"][0]).to be(123456)
        expect(offices["1"][1]).to be(173412)
        expect(offices["1"][2]).to be(109324)
    end
end
