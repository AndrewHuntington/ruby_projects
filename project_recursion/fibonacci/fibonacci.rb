module Fibonacci
  # take a number and return that many members of the Fibonacci sequence
  # Fn = Fn-1 + Fn-2 (given the first two values are 0 and 1)
  # 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55...

  def self.fibs(number)
    # uses iteration
    sequence = [0, 1]

    return [] if number <= 0
    return sequence[0..number-1] if number <= 2


    2.upto(number-1) do |n|
      sequence << (sequence[n-1]) + (sequence[n-2])
    end

    sequence
  end

  def self.fibs_rec(n=0)
    # uses recursion
    puts "hi from fibs_rec!"
  end

end

# Fibonacci.fibs(10) # => [0, 1, 1, 2, 3, 5, 8, 13, 21, 34] OK!
# Fibonacci.fibs_rec(10) # => [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
