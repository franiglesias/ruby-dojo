require_relative 'command_logger_middleware.rb'

class CommandBus
  def initialize(resolver, middleware)
    @resolver = resolver
    @middleware = middleware
  end

  def execute(command)
    @middleware.execute(command, self)
  end
  def handle(command)
    executor = @resolver.executor_for(command)
    executor.execute(command)
  end
end
