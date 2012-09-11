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
    move = rand(9)
    gets
    puts move
    move

  end

  def log(message)
    $stderr.puts "[Player #{@name} #{Time.now.strftime("On %D at %I:%M%p")}] #{message}"
  end

  def print_board(board)
    puts "\n
               |          |
               |          |
            #{board[0][0]}  |    #{board[0][1]}     |   #{board[0][0]}
     __________|__________|__________
               |          |
            #{board[0][0]}  |    #{board[0][1]}     |   #{board[0][0]}
               |          |
     __________|__________|__________
               |          |
            #{board[0][0]}  |    #{board[0][1]}     |   #{board[0][0]}
               |          |
               |          |"

  end
end

server_uri = 'druby://192.168.1.70:4000'
server = DRbObject.new_with_uri(server_uri)
client = Client.new(server,ARGV[0])
DRb.thread.join

