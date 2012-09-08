require 'drb/drb'

uri = ARGV[0]
there = DRbObject.new_with_uri(uri)
there.puts('Hello, World.')
