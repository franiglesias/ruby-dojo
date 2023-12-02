# frozen_string_literal: true

class ConsumptionsProvider
    def initialize(provider = CsvConsumptionsProvider.new)
        @provider = provider
    end
    def from_file(file_name)
        extension = File.extname(file_name)
        if extension == ".csv"
            return @provider.from_file(file_name)
        end
        raise NotImplementedError.new , "#{extension} file support not implemented"
    end
end
