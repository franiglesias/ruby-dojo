# frozen_string_literal: true

class ClockRepository
  def initialize(storage)
    @storage = storage
  end

  def retrieve
    seconds = @storage.read
    Clock.new(seconds, 7, 22)
  end

  def persist(clock)
    @storage.save(clock.seconds)
  end
end
