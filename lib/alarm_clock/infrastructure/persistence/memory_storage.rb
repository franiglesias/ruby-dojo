# frozen_string_literal: true

class MemoryStorage
  def initialize
    @data = 0
  end

  def save(data)
    @data = data
  end

  def read
    @data
  end
end
