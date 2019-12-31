def stock_picker stock_prices
  highest_profit = 0
  buy_index = 0
  sell_index = 0

  stock_prices.each { |price|
    y = stock_prices.index(price) + 1
    x = stock_prices.index(price)

    while y < stock_prices.length - 1
      if (stock_prices[y] - stock_prices[x]) > highest_profit
        highest_profit = stock_prices[y] - stock_prices[x]
        buy_index = x
        sell_index = y
      end

      y += 1
    end
  }

  return [buy_index, sell_index]
end

# Should return a pair of days representing the best day to buy and the best day to sell

# Base cases
stock_picker([17,3,6,9,15,8,6,1,10])
# => [1,4]  for a profit of $15 - $3 == $12 - OK
stock_picker([3,8,1,10,15,32,9,11,19])
# => [2,5]  for a profit of $15 - $1 == $31 - OK

# Pay attention to edge cases like when the lowest day is the last day or the highest day is the first day.

# Edge case
stock_picker([17,6,9,15,8,6,3,10,1])
# => [1, 3] seems to work ok...
