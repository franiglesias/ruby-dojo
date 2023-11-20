class EventBus
  def initialize(resolver, middleware)
    @resolver = resolver
    @middleware = middleware
  end

  def publish(event)
    @middleware.execute(event, self)
  end

  def publish_events(events)
    events.each do |event|
      publish(event)
    end
  end

  def handle(event)
    listeners = @resolver.listeners_for(event)
    return if listeners.nil?

    listeners.each do |listener|
      listener.handle(event)
    end
  end
end
