require 'drb'
require 'colorize'
  
class Client
  attr_accessor :server, :player
  include DRbUndumped

  def initialize(server, player)
    DRb.start_service("druby://localhost:0")
    @server, @player = server, player
    log "Login on server at #{DRb.uri}"
    login
  end

  def hello_from_server
    puts "Welcome to the best Tic-Tac-Toe"
  end
 
  def login
    @server.list_users(self)
  end

  def movement
    puts "Make a play".blue
    move = $stdin.gets.chomp
  end

  def log(message)
    $stderr.puts "[Player #{@name} #{Time.now.strftime("On %D at %I:%M%p")}] #{message}".blue
  end

  def log_error(message)
    puts "Error: #{message}".red
  end

  def print_board(board)
    puts "\n
               |          |
               |          |
          #{board[0][0]}    |    #{board[0][1]}     |    #{board[0][2]}
     __________|__________|__________
               |          |
          #{board[1][0]}    |    #{board[1][1]}     |    #{board[1][2]}
               |          |
     __________|__________|__________
               |          |
          #{board[2][0]}    |    #{board[2][1]}     |    #{board[2][2]}
               |          |
               |          |"

  end
end

if ARGV.length.eql? 2
  server_uri = 'druby://localhost:' +  ARGV[1]
else
  server_uri = 'druby://localhost:4000'
end
server = DRbObject.new_with_uri(server_uri)
client = Client.new(server,ARGV[0])
DRb.thread.join

