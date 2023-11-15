class CommandLoggerMiddleware
  def execute(command, bus)
    log = File.open('clock.log', 'a')
    log.write("#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}: Executing #{command.class.name}\n")

    bus.handle(command)

    log.write("#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}: #{command.class.name} finished\n")
    log.close
  end
end
