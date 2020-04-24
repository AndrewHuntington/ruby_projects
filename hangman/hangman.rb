# This is a hangman game where the player can save his state mid game.
# TODO:
# 1. Win/Lose conditions -- DONE
# 2. Display chosen letters -- DONE
# 3. Save/Quit/Load Functionality -- DONE
# 4. Error detection/prevention -- DONE
#     Raise a warning:
#       -if player chooses a letter that was already chosen -DONE
#       -if player chooses something invalid (a number, etc.) -DONE
# 5. Add graphic that displays the "hangman" (maybe)
# 6. remove/comment out debugging code --DONE

class Game
  def intro
    puts
    puts "Welcome to Hangman."
    puts "Please press '1' for a NEW GAME."
    puts "Please press '2' to LOAD YOUR PREVIOUS GAME."
    puts
    print "Enter your selection: "
    choice = gets.chomp

    if choice == "1"
      start
    elsif choice == "2"
      load_game
    else
      puts
      puts "Invalid selection. Please try again."
      intro
    end

  end

  def load_game
    save_data = {}
    puts
    puts "Loading game..."
    sleep(2)
    puts "OK!"
    puts
    File.open("save.txt") do |f|
      save_data = Marshal.load(f)
    end

    @tries_left = save_data[:tries_left]
    @guessed_letters = save_data[:guessed_letters]
    @secret_word = save_data[:secret_word]
    @blank_word = save_data[:blank_word]
    start
  end

  def save_game
    puts
    puts "Saving data..."
    save_data = {
      tries_left: @tries_left,
      guessed_letters: @guessed_letters,
      secret_word: @secret_word,
      blank_word: @blank_word
    }

    File.open("save.txt", "w") do |f|
      Marshal.dump(save_data, f)
    end
    sleep(2)
    puts "OK!"
    puts
    puts "Quiting game..."
    exit
  end

  def start
    @tries_left ||= 6
    @guessed_letters ||= []
    @secret_word ||= choose_word.upcase.split('')
    @blank_word ||= ("_" * @secret_word.length).split('')

    # # DEBUG: use theese next lines for debugging purposes
    # puts
    # puts "The secret word is: #{@secret_word.join}"
    # puts
    display_word
  end

  def choose_word
    dictionary = File.open("./dictionary/5desk.txt", "r") do |file|
      file.read.lines(chomp: true)
    end

    dictionary.filter do |w|
      w.length >= 5 && w.length <= 12
    end.sample
  end

  def display_word
    @on_screen_word = @blank_word.join(" ")

    puts "#{@on_screen_word}"
    enter_guess
  end

  def enter_guess
    puts
    puts "**Enter '1' to save and quit the game.**"
    puts "Letters guessed so far: #{@guessed_letters.uniq}"
    print "Enter a letter (Tries remaining: #{@tries_left}): "
    guess = input_error_check(gets.chomp.upcase)

    save_game if guess == "1"

    @guessed_letters << guess

    @secret_word.each_with_index do |letter, index|
      @blank_word[index] = guess if guess == letter
    end

    @tries_left -= 1 unless @secret_word.include?(guess)

    check_for_win
    check_for_loss
    display_word
  end

  def input_error_check(guess)
    until guess.size == 1
      print "Too many characters! Please enter a letter: "
      guess = input_error_check(gets.chomp.upcase)
    end

    while @guessed_letters.include?(guess)
      print "You've already tried '#{guess}'. Guess again: "
      guess = input_error_check(gets.chomp.upcase)
    end

    until guess.match?(/[A-Z]/)
      break if guess == '1'
      print "'#{guess}' is invalid. Guess again: "
      guess = input_error_check(gets.chomp.upcase)
    end

    guess
  end

  def check_for_win
    if @secret_word.join == @blank_word.join
      puts
      puts "The secret word was: #{@secret_word.join}!"
      puts "Congrats! You win!"
      puts
      game_over
    end
  end

  def check_for_loss
    if @tries_left == 0
      puts
      puts "The secret word was: #{@secret_word.join}!"
      puts "Sorry, you lose!"
      puts
      game_over
    end
  end

  def game_over
    ready = false

    while !ready
      puts "Play again? (Y/N)"
      choice = gets.chomp.upcase

      if choice == "Y"
        ready = true
        wipe_data
        start
      elsif choice == "N"
        ready = true
        puts "Goodbye!"
        puts
        exit
      else
        puts "Please select either 'Y' or 'N'."
        puts
      end
    end
  end

  def wipe_data
    @tries_left = nil
    @guessed_letters = nil
    @secret_word = nil
    @blank_word = nil
  end
end

game = Game.new
game.intro
