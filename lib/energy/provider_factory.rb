# frozen_string_literal: true

require_relative 'json_consumptions_provider'
require_relative 'csv_consumptions_provider'

class ProviderFactory
    def make_provider(file_name)
        extension = File.extname(file_name)
        provider = nil
        if extension == ".csv"
            provider = CsvConsumptionsProvider.new
        end
        if extension == ".json"
            provider = JsonConsumptionsProvider.new
        end
        if provider.nil?
            raise NotImplementedError.new, "#{extension} file support not implemented"
        end
        provider
    end
end
