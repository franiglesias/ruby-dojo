# frozen_string_literal: true

PlayBeepCommand = Struct.new(:time)

class PlayBeepHandler
  def initialize(sound)
    @sound = sound
  end

  def execute(command)
    raise ArgumentError, 'invalid command' unless command.is_a? PlayBeepCommand

    @sound.beep
  end
end
