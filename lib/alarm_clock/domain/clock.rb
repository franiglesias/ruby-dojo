# frozen_string_literal: true

class Clock
  attr_reader :seconds

  def initialize(seconds, awake, bedtime)
    @seconds = seconds
    @awake = awake
    @bedtime = bedtime
    @events = []
  end

  def tick
    @seconds += 1
    @seconds = 0 if @seconds >= 86_400

    return if secs != 0
    return if minute != 0

    notify(DotHourReached.new(hour))
    notify(AwakeHourReached.new(hour)) if hour == @awake
    notify(BedTimeHourReached.new(hour)) if hour == @bedtime
  end

  def events
    pending = @events
    @events = []
    pending
  end

  private

  def notify(event)
    @events.append(event)
  end

  def secs
    (@seconds % 3600) % 60
  end

  def minute
    (@seconds % 3600) / 60
  end

  def hour
    @seconds / 3600
  end
end
