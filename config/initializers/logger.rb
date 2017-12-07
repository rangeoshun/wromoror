class Logger
  def format_message(severity, timestamp, progname, msg)
    "#{severity.chars[0]} [#{timestamp.strftime("%Y-%m-%d %H:%M:%S:%L")}] [#{$$}] #{msg}\n"
  end
end
