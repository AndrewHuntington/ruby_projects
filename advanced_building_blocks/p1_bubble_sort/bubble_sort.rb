def bubble_sort array
  sorted = false
  x = 0
  n = 1

  while !sorted && x < array.length - 1
    times_swapped = 0

    (0...array.length - n).each do |i|
      if (array[i] <=> array[i+1]) == 1
        temp = array[i]
        array[i] = array[i+1]
        array[i+1] = temp
        times_swapped += 1
      end
    end

    if times_swapped == 0
      sorted = true
    else
      n += 1
      x += 1
    end
  end

  array
end

bubble_sort([4,3,78,2,0,2])


def bubble_sort_by array
  sorted = false
  x = 0
  n = 1

  while !sorted && x < array.length - 1
    times_swapped = 0

    (0...array.length - n).each do |i|
      if yield(array[i], array[i+1]) > 0
        temp = array[i]
        array[i] = array[i+1]
        array[i+1] = temp
        times_swapped += 1
      end
    end

    if times_swapped == 0
      sorted = true
    else
      n += 1
      x += 1
    end
  end

  array
end

bubble_sort_by(["hi","hello","hey"]) do |left,right|
  left.length - right.length
end
