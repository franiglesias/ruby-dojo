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


class EmojiShowTimeHandler
  def initialize(display)
    @display = display
  end

  def execute(command)
    raise ArgumentError, 'invalid command' unless command.is_a? ShowTimeCommand

    emojis = [
      "🕛", "🕐", "🕑", '🕒', "🕓", "🕔", "🕕", "🕖", "🕗", "🕘", "🕙", "🕚"
    ]
    pick = command.time % 12
    emoji = emojis[pick]

    @display.show("#{emoji}")
  end
end
