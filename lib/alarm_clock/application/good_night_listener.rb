# frozen_string_literal: true

require_relative '../domain/bed_time_hour_reached'

class GoodNightListener
  def initialize(display, language)
    @display = display
    @language = language
  end

  def handle(event)
    raise ArgumentError, 'invalid event' unless event.is_a? BedTimeHourReached

    print "#{event.hour}:00 -> "
    @display.show(@language.good_night)
  end
end
