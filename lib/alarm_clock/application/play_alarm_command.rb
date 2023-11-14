# frozen_string_literal: true

PlayAlarmCommand = Struct.new(:time)

class PlayAlarmHandler
  def initialize(sound)
    @sound = sound
  end

  def execute(command)
    raise ArgumentError, 'invalid command' unless command.is_a? PlayAlarmCommand

    @sound.alarm
  end
end
