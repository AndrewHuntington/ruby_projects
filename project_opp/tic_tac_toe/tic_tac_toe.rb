class Game
  WIN = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]].freeze

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @turn_count = 0
    @field = [ "",
               "1", "2", "3",
               "4", "5", "6",
               "7", "8", "9"
             ] # We ignore index 0 for simplicity
  end

  def create_board
    puts
    @field.each_index do |i|
      if i % 3 == 0
        p @field[(i-2)..i] unless i == 0
      end
    end
    puts
  end

  def get_move(player)
    create_board

    print "(#{player.marker}) Enter your square, #{player.name}: "
    move = gets.chomp.to_i
    player.moves_history << move
    player_history_sorted = player.moves_history.sort.join

    if @field[move] != "X" && @field[move] != "O" && (1..9).include?(move)
      @field[move] = player.marker
    else
      puts
      puts "That is not a valid square. Please try again."
      get_move(player)
    end

    check_win(player, player_history_sorted)
  end

  def game_over
    puts
    print "Play again? (Y/N): "
    input = gets.chomp.to_s.downcase
    puts

    if input == "y"
      Game.start
    elsif input == "n"
      puts "Good bye!"
      exit
    else
      puts "Sorry, type either a 'Y or an 'N'."
      game_over
    end
  end

  def check_win(player, player_history_sorted)
    WIN.each do |d1|
      count = 0

      d1.each do |d2|
        if player_history_sorted.include?(d2.to_s)
          count += 1
        end

        if count == 3
          create_board
          puts "Congratulations, #{player.name}! You win!"
          game_over
        end
      end
    end

    if @turn_count >= 9
      create_board
      puts "Oh no! It's a tie. Why don't you try again?"
      game_over
    end

    turn
  end

  def turn
    @turn_count += 1

    player = @turn_count.odd? ? @player1 : @player2

    get_move(player)
  end

  def self.start
    print "Please enter a name for player one (X): "
    p1_name = gets.chomp
    print "Please enter a name for player two (O): "
    p2_name = gets.chomp

    p1 = Player.new(p1_name, 'X')
    p2 = Player.new(p2_name, 'O')
    @game = Game.new(p1, p2)

    @game.turn
  end
end

class Player
  attr_accessor :name, :moves_history
  attr_reader   :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
    @moves_history = []
  end
end

Game.start
