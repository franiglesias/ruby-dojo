# frozen_string_literal: true

class ConsumptionsProvider
    def initialize(provider = CsvConsumptionsProvider.new)
        @provider = provider
    end
    def from_file(file_name)
        @provider.from_file(file_name)
    end
end
