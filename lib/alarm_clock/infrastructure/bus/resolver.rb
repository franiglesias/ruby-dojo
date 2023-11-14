class Resolver
  def initialize
    @executors = {}
  end

  def register(command, executor)
    @executors[command] = executor
  end

  def executor_for(command)
    @executors[command.class.name]
  end
end
