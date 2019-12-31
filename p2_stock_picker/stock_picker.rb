def stock_picker stock_prices

end

stock_picker([17,3,6,9,15,8,6,1,10])
# => [1,4]  for a profit of $15 - $3 == $12

# Should return a pair of days representing the best day to buy and the best day to sell
# You need to buy before you can sell
# Pay attention to edge cases like when the lowest day is the last day or the highest day is the first day.
