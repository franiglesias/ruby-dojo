class Middleware
  def initialize(next_middleware = nil)
    @next = next_middleware
  end

  def execute(command, bus)
    handle(command, bus)
  end

  def handle(command, bus)
    if @next.nil?
      bus.handle(command)
    else
      @next.execute(command, bus)
    end
  end
end
