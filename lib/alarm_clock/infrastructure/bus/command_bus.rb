class CommandBus
  def initialize(resolver)
    @resolver = resolver
  end

  def execute(command)
    executor = @resolver.executor_for(command)
    executor.execute(command)
  end
end
