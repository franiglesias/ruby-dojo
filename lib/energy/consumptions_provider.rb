# frozen_string_literal: true

require_relative 'provider_factory'

class ConsumptionsProvider
    def initialize(factory = ProviderFactory.new)
        @factory = factory
    end
    def from_file(*file_names)
        data = []
        file_names.each do |file_name|
            data.push(*read_file(file_name))
        end
        data
    end

    def read_file(file_name)
        provider = select_provider(file_name)
        provider.from_file(file_name)
    end

    def select_provider(file_name)
        @factory.make_provider(file_name)
    end
end
