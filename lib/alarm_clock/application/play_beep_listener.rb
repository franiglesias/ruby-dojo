# frozen_string_literal: true
require_relative '../domain/dot_hour_reached'

class PlayBeepListener
  def initialize(sound)
    @sound = sound
  end

  def handle(event)
    raise ArgumentError, 'invalid event' unless event.is_a? DotHourReached

    @sound.beep
  end
end
