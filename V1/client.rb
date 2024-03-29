require 'drb'
require 'colorize'

class Client
  attr_accessor :server, :player
  include DRbUndumped

  def initialize(server, player)
    DRb.start_service
    @server, @player = server, player
    log "Login on server at #{DRb.uri}"
    login
  end

  def hello_from_server
    puts "welcome to the best 'triqui at the world'"
  end

  def login
    @server.list_users(self)
  end

  def movement
    puts "tell me your movement"
    move = $stdin.gets.chomp
  end

  def log(message)
    $stderr.puts "[Player #{@name} #{Time.now.strftime("On %D at %I:%M%p")}] #{message}"
  end

  def print_board(board)
    puts "\n
               |          |
               |          |
            #{board[0][0]}  |    #{board[0][1]}     |   #{board[0][2]}
     __________|__________|__________
               |          |
            #{board[1][0]}  |    #{board[1][1]}     |   #{board[1][2]}
               |          |
     __________|__________|__________
               |          |
            #{board[2][0]}  |    #{board[2][1]}     |   #{board[2][2]}
               |          |
               |          |"

  end
end

server_uri = 'druby://192.168.1.70:4000'
server = DRbObject.new_with_uri(server_uri)
client = Client.new(server,ARGV[0])
DRb.thread.join

