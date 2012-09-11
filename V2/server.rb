require 'drb' #ruby distributed
require 'colorize'
class Server
  include DRbUndumped

  def initialize
    DRb.start_service("druby://192.168.1.70:4000", self)
    log("Start server at #{DRb.uri}")
    @list_users= []
    @board = [
              [0,0,0],
              [0,0,0],
              [0,0,0]
              ]
  end

  def list_users(user)
    @list_users << user
    puts "user #{@list_users.count}"
    user.log("welcome player")
    if @list_users.count.eql? 2
      game
    end
  end

  def gets

  end

  def game
    game = [@list_users[0],@list_users[1],@board]
    @list_users[0].print_board(@board)
    @list_users[1].print_board(@board)
    i = 0
    player = 0
    while i < 9
       @list_users[player].log("is your turn #{player} ")
       move = @list_users[player].movement
       puts "move of player #{[player]} is #{move}"
       position(move,player)
       @list_users[0].print_board(@board)
       @list_users[1].print_board(@board)
       if player.eql? 0
         player = 1
       else
         player = 0
       end
       i += 1
    end

  end

  def position(move, player)
    letter = "X"
    if player.eql? 0
      letter = "O"
    end
    case move
      when "1"
        @board[0][0] = letter
      when "2"
        @board[0][1] = letter
      when "3"
        @board[0][2] = letter
      when "4"
        @board[1][0] = letter
      when "5"
        @board[1][1] = letter
      when "6"
        @board[1][2] = letter
      when "7"
        @board[2][0] = letter
      when "8"
        @board[2][1] = letter
      when "9"
        @board[2][2] = letter
      else
        "error"
    end
  end

  def turn

  end

  def log(message)
    puts "[Server #{Time.now.strftime("On %D at %I:%M%p")}] #{message}".blue
  end


end
server = Server.new
DRb.thread.join()