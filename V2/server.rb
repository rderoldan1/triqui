require 'drb'
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
    user.log("Welcome player")
    if @list_users.count.eql? 2
      game
    end
  end

  def reset_game
    @board = [
              ["_","_","_"],
              ["_","_","_"],
              ["_","_","_"]
              ]
    game
  end

  def game
    game = [@list_users[0],@list_users[1],@board]
    @list_users[0].print_board(@board)
    @list_users[1].print_board(@board)
    i = 0
    player = 0
    while i < 9
      @list_users[player].log("New game, Good Luck and have fun!")
       @list_users[player].log("It's your turn #{player}")
       move = @list_users[player].movement
       puts "Move of player #{[player]} is #{move}"
       code = position(move,player)
       if code.eql? 1
         @list_users[player].log_error("Invalid Move, please chose a number within 1 and 9")
       elsif code.eql? 2
         @list_users[player].log_error("Please choose another position")
       elsif code.eql? 3
         @list_users[player].log("We have a winner !")
         @list_users[0].print_board(@board)
         @list_users[1].print_board(@board)
         reset_game
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

  def check_winner(letter, player)
    code = 0
    if @board[0][0] == @board[0][1] and @board[0][1] == @board[0][2] and @board[0][2] == letter
      code = 3
    elsif @board[1][0] == @board[1][1] and @board[1][1] == @board[1][2] and @board[1][2] == letter
      code = 3
    elsif @board[2][0] == @board[2][1] and @board[2][1] == @board[2][2] and @board[2][2] == letter
      code = 3
    elsif @board[0][0] == @board[1][0] and @board[1][0] == @board[2][0] and @board[2][0] == letter
      code = 3
    elsif @board[0][1] == @board[1][1] and @board[1][1] == @board[2][1] and @board[2][1] == letter
      code = 3
    elsif @board[0][2] == @board[1][2] and @board[1][2] == @board[2][2] and @board[2][2] == letter
      code = 3
    elsif @board[0][0] == @board[1][1] and @board[1][1] == @board[2][2] and @board[2][2] == letter
      code = 3
    elsif @board[0][2] == @board[1][1] and @board[1][1] == @board[2][0] and @board[2][0] == letter
      code = 3 
    else
      puts "No winner yet."
    end
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
      exit_code = check_winner(letter, player)
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