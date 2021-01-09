# My first attempt. Doesn't use classes/OOP principals, so I redid it.

# initialization variables
round = 1
player_col = ""
player_row = ""
coords = ""
player_positions = Hash.new("-")

def display_board(player_positions)
row_number = 1

puts ""

  5.times do |n|

    if n == 0
      puts "  A B C"
    end

    if n % 2 == 0
      puts "#{row_number} #{player_positions["a#{row_number}"]}|#{player_positions["b#{row_number}"]}|#{player_positions["c#{row_number}"]}"
      row_number += 1
    else
      puts "  -----"
    end
  end

  puts ""
end

def check_cols(player_positions)
  ('a'..'c').each do |a|
    count_x = 0
    count_o = 0

    (1..3).each do |n|
      if player_positions["#{a}#{n}"] != '-'
        if player_positions["#{a}#{n}"] == 'X'
          count_x += 1
        else
          count_o += 1
        end
      end
    end

    if count_x >= 3 || count_o >= 3
      puts count_x >= 3 ? "X wins!" : "O wins!"
      return true
    end
  end

  return false
end

def check_rows(player_positions)
  (1..3).each do |n|
    count_x = 0
    count_o = 0

    ('a'..'c').each do |a|
      if player_positions["#{a}#{n}"] != '-'
        if player_positions["#{a}#{n}"] == 'X'
          count_x += 1
        else
          count_o += 1
        end
      end
    end

    if count_x >= 3 || count_o >= 3
      puts count_x >= 3 ? "X wins!" : "O wins!"
      return true
    end
  end

  return false
end

def left_to_right_decending(player_positions)
  row = 1
  count_x = 0
  count_o = 0

  # a1 b2 c3
  ('a'..'c').each do |a|
    if player_positions["#{a}#{row}"] != '-'
      if player_positions["#{a}#{row}"] == 'X'
        count_x += 1
      else
        count_o += 1
      end
    end

    row += 1
  end

  if count_x >= 3 || count_o >= 3
    puts count_x >= 3 ? "X wins!" : "O wins!"
    return true
  end

  return false
end

def left_to_right_ascending(player_positions)
  row = 1
  count_x = 0
  count_o = 0

  # c1 b2 a3
  ('a'..'c').reverse_each do |a|
    if player_positions["#{a}#{row}"] != '-'
      if player_positions["#{a}#{row}"] == 'X'
        count_x += 1
      else
        count_o += 1
      end
    end

    row += 1
  end

  if count_x >= 3 || count_o >= 3
    puts count_x >= 3 ? "X wins!" : "O wins!"
    return true
  end

  return false
end

def check_diagonals(player_positions)

  if left_to_right_decending(player_positions)
    return true
  end

  if left_to_right_ascending(player_positions)
    return true
  end

  return false
end

def game_over?(round, player_positions)
  # check rows for 3 in a row
  if check_rows(player_positions)
    return true
  end

  # check cols for 3 in a row
  if check_cols(player_positions)
    return true
  end

  # check diagonals
  if check_diagonals(player_positions)
    return true
  end

  # if board is full
  if round >= 10
     puts "It's a tie!"
     return true
   end

   return false
end

display_board(player_positions)

def player_input(player, round)
  puts "Round: #{(round / 2.0).round} Turn: #{player[1]}"
  print "Player #{player[0]} (#{player[1]}), please choose a column: "
  player_col = gets.chomp.to_s.downcase
  # catch errors
  while !('a'..'c').include?(player_col)
    print "(#{player[1]}) Please enter either 'A' 'B' or 'C': "
    player_col = gets.chomp.to_s.downcase
  end
  print "Player #{player[0]} (#{player[1]}), please choose a row: "
  player_row = gets.chomp.to_s
  # catch errors
  while !('1'..'3').include?(player_row)
    print "(#{player[1]}) Please enter either '1' '2' or '3': "
    player_row = gets.chomp.to_s
  end

  player_col + player_row
end

while !game_over?(round, player_positions)
  if round % 2 != 0
    player = [1, 'X']
  else
    player = [2, 'O']
  end

  # p player_positions # nice for debugging

  coords = player_input(player, round)

  # won't allow either player to pick an occupied spot
  if player_positions.include?(coords)
    while player_positions.include?(coords)
      puts ""
      puts "Sorry, that space is already taken. Try again."
      coords = player_input(player, round)
    end
  end

  player_positions[coords] = player[1]
  display_board(player_positions)
  round += 1
end
