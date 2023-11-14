class AlarmClock
  def initialize(command_bus, awake_at, sleep_at)
    @command_bus = command_bus
    @awake_at = awake_at
    @sleep_at = sleep_at
  end

  def run
    24.times do |hour|
      case hour
      when @awake_at
        @command_bus.execute(GoodMorningCommand.new(hour))
        @command_bus.execute(PlayAlarmCommand.new(hour))
      when @sleep_at
        @command_bus.execute(GoodNightCommand.new(hour))
      else
        @command_bus.execute(ShowTimeCommand.new(hour))
        @command_bus.execute(PlayBeepCommand.new(hour))
      end
    end
  end
end
