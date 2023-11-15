require_relative 'middleware'

class CommandLoggerMiddleware < Middleware
  def initialize(next_middleware = nil)
    super
  end
  def execute(command, bus)
    log = File.open('clock.log', 'a')
    log.write("#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}: Executing #{command.class.name}\n")

    handle(command, bus)

    log.write("#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}: #{command.class.name} finished\n")
    log.close
  end

  def handle(command, bus)
    super
  end
end
