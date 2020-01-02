module Enumerable
  def my_each
    0.upto(self.length-1) do |index|
      yield(self[index])
    end

    self
  end

  def my_each_with_index
    0.upto(self.length-1) do |index|
      yield(self[index], index)
    end

    self
  end

  def my_select
    new_a = []
    self.my_each do |element|
      if yield(element)
        new_a << element
      end
    end

    new_a
  end

  def my_all?
    self.my_each do |element|
      if !yield(element)
        return false
      end
    end

    true
  end

  def my_any?
    self.my_each do |element|
      if yield(element)
        return true
      end
    end

    false
  end

  def my_none?
    self.my_each do |element|
      if yield(element)
        return false
      end
    end

    true
  end

  def my_count item=nil
    counter = 0

    if block_given?
      self.my_each do |element|
        counter +=1 if yield(element)
      end

      return counter
    end

    if item
      self.my_each do |element|
        if element == item
          counter += 1
        end
      end
      return counter
    else
      return self.length
    end

  end

  def my_map
    new_a = []
    self.my_each do |element|
      new_a << yield(element)
    end

    new_a
  end

  def my_inject init=self.first
    # code goes here
  end

end

# ################TESTS################

# ----------each vs. my_each ----------
# each_result = []
# [1,2,3].each  { |item| each_result << item * 2 }
# print "#each result: #{each_result}\n"

# my_each_result = []
# [1,2,3].my_each  { |item| my_each_result << item * 2 }
# print "#my_each result: #{my_each_result}\n"


# ----------each_with_index vs. my_each_with_index ----------
# [1,2,3].each_with_index  { |item, index| p [item, index] }

# [1,2,3].my_each_with_index  { |item, index| p [item, index] }

# ----------select vs. my_select ----------
# a = [1,2,3,4]
# a.select { |n| n.even? }
# => [2, 4] **the array is not changed

# [1,2,3,4].my_select { |n| n.even? }

# ----------all? vs. my_all? ----------
# [1,2,3,4].all? { |n| n > 5 } # => false

# [1,2,3,4].my_all? { |n| n < 5 } # => true

# ----------any? vs. any? ----------
# [1,2,3,4].any? { |n| n > 3 } # => true
# [1,2,3,4].any? { |n| n > 100 } # => false

# [1,2,3,4].my_any? { |n| n > 3 } # => true
# [1,2,3,4].my_any? { |n| n > 100 } # => false

# ----------none? vs. my_none? ----------
# %w{ant bear cat}.none? {|word| word.length == 5}  # => true
# %w{ant bear cat}.none? {|word| word.length >= 4}  # => false

# %w{ant bear cat}.my_none? {|word| word.length == 5}  # => true
# %w{ant bear cat}.my_none? {|word| word.length >= 4}  # => false

# ----------count vs. my_count ----------
# ary = [1, 2, 4, 2]

# ary.count             # => 4 no param
# ary.count(2)          # => 2 param
# ary.count{|x|x%2==0}  # => 3 w/block

# ary.my_count             # => 4 no param
# ary.my_count(2)          # => 2 param
# ary.my_count{|x|x%2==0}  # => 3 w/block

# ----------map vs. my_map ----------
# p [1, 2, 3].map {|n| n * 3 }  # => [3, 6, 9]
# p [1, 2, 3].my_map {|n| n * 3 }  # => [3, 6, 9]

# ----------inject vs. my_inject ----------
p [2, 3, 4, 5].inject {|result, item| result + item }        #=> 14
p [2, 3, 4, 5].inject(0) {|result, item| result + item**2 }  #=> 54

p [2, 3, 4, 5].my_inject {|result, item| result + item }        #=> 14
p [2, 3, 4, 5].my_inject(0) {|result, item| result + item**2 }  #=> 54
