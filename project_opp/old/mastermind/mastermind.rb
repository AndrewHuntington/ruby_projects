# NOTE: A simple implimentation of the game Mastermind: only one round of play, doesn't keep score, and the code can only be made up of non-repeating, non-blank values.

# Thanks to stackoverflow user 'Pete' for which this module is based on...
# This module will shuffle white answers, while leaving the red alone.
# So basically, the computer will keep guessing w/white numbers, but not know
# where to put them, while keeping red numbers in place. Not really how a human
# would guess, since the red and white indicators are placed randomly,
# i.e. in a human vs. human match, a red marker will let you know you have a
# correct color in the correct hole, but it doesn't tell you which color/hole
# it is, but I built it to the specs listed on https://www.theodinproject.com/lessons/oop
module ArrayExtender
  def shuffle_except(indexes)
    clone = self.clone

    indexes.each do |index|
      clone.delete_at(index)
    end

    indexes.each do |index|
      clone.shuffle!.insert(index, self[index])
    end
  end
end

class Game
  def initialize(code_maker, code_breaker)
    @code_maker   = code_maker
    @code_breaker = code_breaker
    code = code_breaker.is_human? ? code_maker.create_code_auto : code_maker.create_code_manual
    @turn_count = 0
    @board = [
               [[" ", " ", " ", " "]], #0 (this will contain the code)
               [[" ", " ", " ", " "], []], #1
               [[" ", " ", " ", " "], []], #2
               [[" ", " ", " ", " "], []], #3
               [[" ", " ", " ", " "], []], #4
               [[" ", " ", " ", " "], []], #5
               [[" ", " ", " ", " "], []], #6
               [[" ", " ", " ", " "], []], #7
               [[" ", " ", " ", " "], []], #8
               [[" ", " ", " ", " "], []], #9
               [[" ", " ", " ", " "], []], #10
               [[" ", " ", " ", " "], []], #11
               [[" ", " ", " ", " "], []]  #12
             ] # ignores line 0 when displaying

   if @code_maker.is_human?
     # initialize this variable in order for advanced cpu guessing
     @cpu_next_turn_guess_saved = [nil, nil, nil, nil]
     @cpu_next_turn_guess_saved.extend(ArrayExtender)
   end

   @board[0] = code
  end

  def display_board
    puts "1 = red 2 = green 3 = blue 4 = yellow\n" +
         "5 = brown 6 = orange 7 = black 8 = white"
    puts

    # puts "Code: #{@board[0]}" # DEBUG: show secret code

    @board.each_index do |i|
      p @board[i] unless i == 0
    end
  end

  def give_hint
    hold = [] # will hold indexes to not shuffle

    @board[13 - @turn_count][0].each_with_index do |pin, index|
      if @board[0][index] == pin
        if @code_maker.is_human?
          @cpu_next_turn_guess_saved[index] = @board[13 - @turn_count][0][index]
          hold << index # red guesses don't get shuffled
        end

        @board[13 - @turn_count][1] << "R"
        next
      elsif @board[0].include?(pin)
        @board[13 - @turn_count][1] << "W"

        if @code_maker.is_human?
          random_index = rand(0..3)

          while !@cpu_next_turn_guess_saved.include?(@board[13 - @turn_count][0][index])

            if @cpu_next_turn_guess_saved[random_index].nil?
              @cpu_next_turn_guess_saved[random_index] =                        @board[13 - @turn_count][0][index]
            end

            random_index = rand(0..3)
          end
        end
      else
        @board[13 - @turn_count][1] << " "
      end
    end

    @cpu_next_turn_guess_saved.shuffle_except(hold) if @code_maker.is_human?
    @board[13 - @turn_count][1].shuffle!
  end

  def guess_human
    count = 0

    while count < 4
      print "Please choose a color (1-8) for pin #{count+1}: "
      guess = gets.chomp

      if (1..8).include?(guess.to_i)                                          && !@board[13 - @turn_count][0].include?(guess)
        @board[13 - @turn_count][0][count] = guess
        count += 1
      else
        puts
        puts "Invalid selection. Please try again."
      end
    end

    give_hint
  end

  def guess_cpu
    count = 0
    # REMEMBER: Arrays are passed by reference, not value. Thus .dup is necessary.
    # See: https://www.rubyguides.com/2018/11/dup-vs-clone/
    @board[13 - @turn_count][0] = @cpu_next_turn_guess_saved.dup

    puts "Computer is choosing its colors..."

    while count < 4
      if @board[13 - @turn_count][0][count].nil?
        guess = rand(1..8)

        if !@board[13 - @turn_count][0].include?(guess.to_s)
          @board[13 - @turn_count][0][count] = guess.to_s
          count += 1
        end
      else
        count += 1
      end

    end

    sleep(rand(5..8))
    give_hint
  end

  def ask_play_again
    made_selection = false

    while !made_selection
      puts
      print "Play again? (Y/N): "
      choice = gets.chomp.downcase

      if choice == 'y'
        made_selection = true
        Game.start
      elsif choice == 'n'
        made_selection = true
        puts "Goodbye!"
        exit
      else
        puts "Please select 'Y' or 'N'."
      end

    end

  end

  def check_for_game_over
    if !@board[14 - @turn_count][1].empty?                                    && @board[14 - @turn_count][1].all?(/R/)
      puts "The code breaker wins!"
      ask_play_again
    end

    if @turn_count > 12
      puts "The code maker wins!"
      ask_play_again
    end
  end

  def get_move
    @turn_count += 1
    puts
    puts "(Turn: #{@turn_count})"

    check_for_game_over unless @turn_count == 1

    if @code_breaker.is_human?
      guess_human
    else
      guess_cpu
    end

    puts
    display_board
    get_move
  end

  def self.start
    puts "Welcome to Mastermind!\n" +
         "Please choose 1 to be the code breaker.\n" +
         "Please choose 2 to be the code maker."
    puts
    print "Please enter your selection: "
    choice = gets.chomp

    ready = false

    while !ready
      if choice.to_i == 1
        human_is_codebreaker = true
        human_is_codemaker = false
        ready = true
      elsif choice.to_i == 2
        human_is_codebreaker = false
        human_is_codemaker = true
        ready = true
      else
        puts
        print "Please select 1 or 2: "
        choice = gets.chomp
      end
    end


    code_maker   = CodeMaker.new(human_is_codemaker)
    code_breaker = CodeBreaker.new(human_is_codebreaker)
    @game = Game.new(code_maker, code_breaker)

    @game.display_board
    @game.get_move
  end

end

class Player
  # stuff common to all players
  def initialize
  end

  def is_human?
    @is_human
  end
end

class CodeBreaker < Player
  # methods for CodeBreakers
  def initialize(is_human)
    @is_human = is_human
  end
end

class CodeMaker < Player
  #methods for CodeMakers
  def initialize(is_human)
    @is_human = is_human
    @code = [nil, nil, nil, nil]
  end


  def create_code_auto
    # Basic version - prevents duplicate colors form being used.
    # Used when the CPU is the code maker
    @code.map! do |color|
      random_number = rand(1..8).to_s

      while @code.include?(random_number)
        random_number = rand(1..8).to_s
      end

      color = random_number
    end

    @code.shuffle!
  end

  def create_code_manual(count=0)
    # This will be used when the player is the code master
    puts "1 = red 2 = green 3 = blue 4 = yellow\n" +
         "5 = brown 6 = orange 7 = black 8 = white"
    puts

    count = count

    while !@code.all?(String)
      print "Please choose a color (1-8) for slot #{count+1}: "
      choice = gets.chomp

      if (1..8).include?(choice.to_i) && !@code.include?(choice)
        @code[count] = choice
        count += 1
      else
        puts
        puts "Invalid or duplicate selection. Please try again."
        puts
        create_code_manual(count)
      end
    end

    @code
  end
end

Game.start
