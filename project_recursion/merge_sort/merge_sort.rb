def merge(a, b)
  i = i_a = i_b = 0
  array = []

  while i_a < a.length && i_b < b.length
    if a[i_a] < b[i_b]
      array[i] = a[i_a]
      i_a += 1
    else
      array[i] = b[i_b]
      i_b += 1
    end
    i += 1
  end

  if i_a == a.length
    array = array + b[i_b..-1]
  else
    array = array + a[i_a..-1]
  end

  array
end

def merge_sort(list)
  # if list > 1
  # copy list[0..n/2] to list_a
  # copy list[n/2+1..n] to list_b
  # merge_sort(list_a)
  # merge_sort(list_b)
  # merge list_a + list_b

  return list if list.length < 2

  list_a = list[0...list.length/2]
  list_b = list[list.length/2..-1]

  list_a = merge_sort(list_a)
  list_b = merge_sort(list_b)

  merge(list_a, list_b)
end

a = [1,2,3,4,5,6,7,8].shuffle     # an even numbered test case
b = [1,2,3,4,5,6,7,8,9].shuffle   # an odd numbered test case

puts "Array 'a' before sorting: #{a}"
merged_a = merge_sort(a)
puts "Array 'a' after sorting: #{merged_a}"

puts "Array 'b' before sorting: #{b}"
merged_b = merge_sort(b)
puts "Array 'b' after sorting: #{merged_b}"
