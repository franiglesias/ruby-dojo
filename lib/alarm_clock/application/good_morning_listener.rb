# frozen_string_literal: true

require_relative '../domain/awake_hour_reached'

class GoodMorningListener
  def initialize(display, language)
    @display = display
    @language = language
  end

  def handle(event)
    raise ArgumentError, 'invalid event' unless event.is_a? AwakeHourReached

    print "#{event.hour}:00 -> "
    @display.show(@language.good_morning)
  end
end
