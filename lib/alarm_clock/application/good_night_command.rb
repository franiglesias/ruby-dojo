# frozen_string_literal: true


GoodNightCommand = Struct.new(:time)

class GoodNightHandler
  def initialize(display, language)
    @display = display
    @language = language
  end

  def execute(command)
    raise ArgumentError, 'invalid command' unless command.is_a? GoodNightCommand

    print "#{command.time}:00 -> "
    @display.show(@language.good_night)
  end
end
