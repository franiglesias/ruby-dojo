# frozen_string_literal: true

require_relative 'json_consumptions_provider'
require_relative 'csv_consumptions_provider'

class ProviderFactory
    def initialize
        @providers = {
          ".csv": CsvConsumptionsProvider.new,
          ".json": JsonConsumptionsProvider.new,
        }
    end

    def register(extension, provider)
        @providers[extension] = provider
    end

    def make_provider(file_name)
        extension = File.extname(file_name).to_sym
        unless @providers.key? extension
            raise NotImplementedError.new, "#{extension} file support not implemented"
        end
        @providers[extension]
    end
end
