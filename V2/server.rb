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
       if player.eql? 0
         player = 1
       else
         player = 0
       end
       i += 1
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