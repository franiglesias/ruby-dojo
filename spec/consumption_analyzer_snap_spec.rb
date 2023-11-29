# frozen_string_literal: true

require 'rspec'
require "rspec/snapshot"


require_relative '../lib/energy/consumption_analyzer'

RSpec.describe 'Consumer Analyzer' do
    context "Default behaviour" do
        it "should generate report" do
            a = ConsumptionAnalyzer.new
            result = capture_stdout {a.execute('sample.csv', 1.4)}
            expect(result).to match_snapshot('default_snapshot')
        end
    end
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
