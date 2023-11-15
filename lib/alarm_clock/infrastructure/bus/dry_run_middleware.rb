require_relative 'middleware'

class DryRunMiddleware < Middleware
  def initialize(dry, next_middleware = nil)
    @dry = dry
    super(next_middleware)
  end

  def execute(command, bus)
    handle(command, bus)
  end

  def handle(command, bus)
    if @next.nil?
      bus.handle(command) unless @dry
      puts "Executing #{command.class.name}" if @dry
    else
      @next.execute(command, bus)
    end
  end
end
