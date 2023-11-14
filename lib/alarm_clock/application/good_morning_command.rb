# frozen_string_literal: true

GoodMorningCommand = Struct.new(:time)

class GoodMorningHandler
  def initialize(display, language)
    @display = display
    @language = language
  end

  def execute(command)
    raise ArgumentError, 'invalid command' unless command.is_a? GoodMorningCommand

    print "#{command.time}:00 -> "
    @display.show(@language.good_morning)
  end
end
