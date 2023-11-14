# frozen_string_literal: true

ShowTimeCommand = Struct.new(:time)

class ShowTimeHandler
  def initialize(display)
    @display = display
  end

  def execute(command)
    raise ArgumentError, 'invalid command' unless command.is_a? ShowTimeCommand

    @display.show("#{command.time}:00")
  end
end
