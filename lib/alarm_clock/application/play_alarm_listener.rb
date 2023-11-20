# frozen_string_literal: true
require_relative '../domain/awake_hour_reached'

class PlayAlarmListener
  def initialize(sound)
    @sound = sound
  end

  def handle(event)
    raise ArgumentError, 'invalid event' unless event.is_a? AwakeHourReached

    @sound.alarm
  end
end
