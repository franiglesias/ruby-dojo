# frozen_string_literal: true

class ConsumptionsProvider
    def initialize

    end
    def from_file(*file_names)
        data = []
        file_names.each do |file_name|
            data.push(*read_file(file_name))
        end
        data
    end

    def read_file(file_name)
        extension = File.extname(file_name)
        if extension == ".csv"
            provider = CsvConsumptionsProvider.new
            return provider.from_file(file_name)
        end
        raise NotImplementedError.new, "#{extension} file support not implemented"
    end
end
