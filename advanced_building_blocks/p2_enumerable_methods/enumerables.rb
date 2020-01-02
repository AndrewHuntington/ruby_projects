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
