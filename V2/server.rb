require 'drb' #ruby distributed
require 'colorize'
class Server
  include DRbUndumped

  def initialize
    if ARGV.length.eql? 1
      DRb.start_service("druby://localhost:#{ARGV[0]}", self)
    else
      DRb.start_service("druby://localhost:4000", self)
    end  
      log("Start server at #{DRb.uri}")
      @list_users= []
      @board = [
                ["_","_","_"],
                ["_","_","_"],
                ["_","_","_"]
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

  def valid_movement(move)

  end

  def game
    game = [@list_users[0],@list_users[1],@board]
    @list_users[0].print_board(@board)
    @list_users[1].print_board(@board)
    i = 0
    player = 0
    while i < 9
       @list_users[player].log("It's your turn #{player}")
       move = @list_users[player].movement
       puts "Move of player #{[player]} is #{move}"
       code = position(move,player)
       puts check_winner
       if code.eql? 1
         @list_users[player].log_error("Invalid Move, please chose a number within 1 and 9")
       elsif code.eql? 2
         @list_users[player].log_error("Please choose another position")
       else
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
  end

  def check_winner
    
        @board[0,0] and @board[0,1] and @board[0,2] and "X" or
        @board[1,0] and @board[1,1] and @board[1,2] and "X" or
        @board[2,0] and @board[2,1] and @board[2,2] and "X" or
        @board[0,0] and @board[1,1] and @board[2,2] and "X" or
        @board[0,2] and @board[1,1] and @board[2,0] and "X" or 
        @board[0,0] and @board[0,1] and @board[0,2] and "O" or
        @board[1,0] and @board[1,1] and @board[1,2] and "O" or
        @board[2,0] and @board[2,1] and @board[2,2] and "O" or
        @board[0,0] and @board[1,1] and @board[2,2] and "O" or
        @board[0,2] and @board[1,1] and @board[2,0] and "O"
        
  end



  def position(move, player)
    letter = "X"
    exit_code = 0
    if player.eql? 1
      letter = "O"
    end

    p = case move
      when "1"
        [0,0]
      when "2"
        [0,1]
      when "3"
        [0,2]
      when "4"
        [1,0]
      when "5"
        [1,1]
      when "6"
        [1,2]
      when "7"
        [2,0]
      when "8"
        [2,1]
      when "9"
        [2,2]
      else
        exit_code = 1
    end

    if @board[p[0]][p[1]].eql? "_"
      @board[p[0]][p[1]] = letter
      puts @board[p[0]][p[1]]
    else
      exit_code = 2
    end
    exit_code
  end

  def turn

  end

  def log(message)
    puts "[Server #{Time.now.strftime("On %D at %I:%M%p")}] #{message}".blue
  end


end
server = Server.new
DRb.thread.join()