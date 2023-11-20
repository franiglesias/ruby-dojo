class ListenerResolver
  def initialize
    @listeners = {}
  end

  def register(event, listener)
    @listeners[event] = [] unless @listeners.key?(event)
    @listeners[event].append(listener)
  end

  def listeners_for(event)
    @listeners[event.class.name]
  end
end
