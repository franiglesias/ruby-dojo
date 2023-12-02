# frozen_string_literal: true

class CsvConsumptionsProvider
    def from_file(file_name)
        data = CSV.parse(File.read(file_name), headers: true, converters: :numeric)
        data.map do |row|
            Consumption.new(row["office"], row["year"], row["month"], row["consumption"])
        end
    end
end
