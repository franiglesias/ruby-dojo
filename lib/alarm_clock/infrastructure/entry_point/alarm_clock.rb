# frozen_string_literal: true

class AlarmClock
  def initialize(command_bus, awake_at, sleep_at)
    @command_bus = command_bus
    @awake_at = awake_at
    @sleep_at = sleep_at
  end

  def run
    loop do
      @command_bus.execute(TickCommand.new(@awake_at, @sleep_at))
    end
  end
end
