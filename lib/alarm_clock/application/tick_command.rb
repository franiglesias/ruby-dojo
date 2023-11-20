# frozen_string_literal: true

TickCommand = Struct.new(:awake_at, :sleep_at)

class TickCommandHandler
  def initialize(repository, event_bus)
    @event_bus = event_bus
    @repository = repository
  end

  def execute(command)
    raise ArgumentError, 'invalid command' unless command.is_a? TickCommand

    clock = @repository.retrieve
    clock.tick

    @repository.persist(clock)

    @event_bus.publish_events(clock.events)
  end
end
