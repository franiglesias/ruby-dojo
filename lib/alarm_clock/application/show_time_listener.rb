# frozen_string_literal: true
require_relative '../domain/dot_hour_reached'

class ShowTimeListener
  def initialize(display)
    @display = display
  end

  def handle(event)
    raise ArgumentError, 'invalid event' unless event.is_a? DotHourReached

    @display.show("#{event.hour}:00")
  end
end
