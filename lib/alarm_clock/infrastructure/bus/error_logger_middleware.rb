class ErrorLoggerMiddleware
  def execute(command, bus)
    log = File.open('errors.log', 'a')
    begin
    bus.handle(command)
    rescue => e
      log.write("#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}: #{command.class.name} error: #{e.class.name} with message #{e.message}\n")
    end
    log.close
  end
end
