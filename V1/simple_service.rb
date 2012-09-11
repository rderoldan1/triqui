require 'drb'

class Puts
  def initialize(stream=$stdout)
    @stream = stream
  end

  def puts(str)
    @stream.puts(str)
  end
end

uri = ARGV[0]

DRb.start_service(uri, Puts.new)
puts DRb.uri
DRb.thread.join()