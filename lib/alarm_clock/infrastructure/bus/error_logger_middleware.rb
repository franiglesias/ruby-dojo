require_relative 'middleware'
class ErrorLoggerMiddleware < Middleware
  def initialize(next_middleware = nil)
    super
  end
  def execute(command, bus)
    log = File.open('errors.log', 'a')
    begin
      handle(command, bus)
    rescue => e
      log.write("#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}: #{command.class.name} error: #{e.class.name} with message #{e.message}\n")
    end
    log.close
  end

  def handle(command, bus)
    super
  end
end
