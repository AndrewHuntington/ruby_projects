module Fibonacci
  # take a number and return that many members of the Fibonacci sequence
  # Fn = Fn-1 + Fn-2 (given the first two values are 0 and 1)
  # 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55...
  class << self
    def fibs(n)
      # uses iteration
      sequence = [0, 1]

      return [] if n <= 0
      return sequence[0..n-1] if n <= 2

      2.upto(n-1) do |i|
        sequence << (sequence[i-1]) + (sequence[i-2])
      end

      sequence
    end

    def fibs_rec(n)
      # uses recursion
      return 0 if n == 0
      return 1 if n == 1

      fibs_rec(n-1) + fibs_rec(n-2)
    end

    def fibs_assist
      # this is the only way I can figure out to get the fib_sequence
      # into an array using the recursive function. Maybe it's cheating...
      print "Enter a number: "
      n = gets.to_i

      fib_sequence = []

      n.times do |n|
        fib_sequence[n] = fibs_rec(n)
      end

      fib_sequence
    end
  end
end

# Fibonacci.fibs(10) # => [0, 1, 1, 2, 3, 5, 8, 13, 21, 34] OK!
p Fibonacci.fibs_assist # => [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
