# frozen_string_literal: true

require 'rspec'
require "rspec/snapshot"


require_relative '../lib/energy/consumption_analyzer'

RSpec.describe 'Consumer Analyzer' do
    context "Default behaviour" do
        it "should generate report" do
            a = build_analyzer
            result = capture_stdout {a.execute( 1.4, 'sample.csv')}
            expect(result).to match_snapshot('default_snapshot')
        end
    end

    context "Two sources" do
        it "should generate mixed report" do
            a = build_analyzer
            result = capture_stdout {a.execute( 1.4, 'sample.csv', 'sample_2.json')}
            expect(result).to match_snapshot('two_sources')
        end
    end
end

def build_analyzer
    factory = ProviderFactory.new
    factory.register(".csv", CsvConsumptionsProvider.new)
    factory.register(".json", JsonConsumptionsProvider.new)

    provider = ConsumptionsProvider.new(factory)

    ConsumptionAnalyzer.new(provider)
end

def capture_stdout
    original = $stdout
    foo = StringIO.new
    $stdout = foo
    yield
    $stdout.string
ensure
    $stdout = original
end
