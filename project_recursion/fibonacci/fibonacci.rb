module Fibonacci
  # take a number and return that many members of the Fibonacci sequence
  # Fn = Fn-1 + Fn-2 (given the first two values are 0 and 1)
  # 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55...

  def self.fibs(n=0)
    # uses iteration
    puts "hi from fibs!"
  end

  def self.fibs_rec(n=0)
    # uses recursion
    puts "hi from fibs_rec!"
  end

end

Fibonacci.fibs
Fibonacci.fibs_rec
