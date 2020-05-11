class Node
  attr_accessor :value, :next_node

  def initialize(value=nil, next_node=nil)
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  def initialize
    @list = []
  end

  def append(value)
    # adds a new node containing value to the end of the list
    node = Node.new(value)
    @list << [node.value, node.next_node]

    @list[-2][1] = @list.length-1 if @list.length > 1
  end

  def prepend(value)
    # add a new node containing value to the start of the list
    @list.each do |node|
      node[1] +=1 unless node[1].nil?
    end

    node = Node.new(value, 1)
    @list.unshift([node.value, node.next_node])
  end

  def size
    # returns the total number of nodes in the list
    @list.length
  end

  def head
    # returns the first node in the list
    @list.first
  end

  def tail
    # returns the last node in the list
    @list.last
  end

  def at(index)
    # returns the node at the given index
    @list[index]
  end

  def pop
    # removes the last element from the list
    @list.pop

    @list[-1][1] = nil if @list.length > 1
  end

  def contains?(value)
    # returns true if the passed in value is in the list and otherwise returns false
    @list.each do |node|
      return true if node.include?(value)
    end

    false
  end

  def find(value)
    # returns the index of the node containing value, or nil if not found
    @list.each do |node|
      return @list.index(node) if node.include?(value)
    end

    nil
  end

  def to_s
    # represents your LinkedList objects as strings, so you can print them out and preview them in the console
    # format: ( value  ) -> ( value ) -> ( value ) -> nil
    @list.each do |node|
      print "( #{node[0]} ) -> "
    end
    print "nil\n"
  end

  ########## EXTRA CREDIT ##########
  def insert_at(value, index)
    # inserts the node with the provided value at the given index

    # only allow index numbers within range
    if index >= @list.length || index < 0
      raise ArgumentError, "Whoops! #{index} is out of bounds!"
    end

    # update links of nodes in the list after an insertion
    @list[index..-1].each do |node|
      node[1] += 1 unless node[1].nil?
    end

    node = Node.new(value, index + 1)

    @list.insert(index, [node.value, node.next_node])
  end

  def remove_at(index)
    # removes the node at the given index

    # only allow index numbers within range
    if index >= @list.length || index < 0
      raise ArgumentError, "Whoops! #{index} is out of bounds!"
    end

    if index == @list.length-1
      pop
    else
      @list.delete_at(index)
    end

    # update links of nodes in the list after a removal
    @list[index..-1].each do |node|
      node[1] -= 1 unless node[1].nil?
    end

  end
end

list = LinkedList.new

# test #append
list.append("ruby")
list.append("javascript")
list.append("c++")

# test #prepend
list.prepend("c#")
list.prepend("python")

# test #t0_s
list.to_s

# test #size
puts "List size is: #{list.size}\n\n"

#test #head
puts "Head is #{list.head}\n\n"

#test #tail
puts "Tail is #{list.tail}\n\n"

#test #at
puts "Node at index 1 is #{list.at(1)}\n\n"

#test #contains?
puts "Node contains 'c++': #{list.contains?("c++")}"
puts "Node contains 'pascal': #{list.contains?("pascal")}\n\n"

#test #find?
puts "Found 'ruby' at index: #{list.find("ruby")}"     # pass
puts "Found 'bash' at index: #{list.find("bash")}\n\n" # fail

# #test #insert_at (pass: normal)
# puts "Inserting 'basic' at index 2..."
# list.insert_at('basic', 2)

#test #insert_at (edge case: insert at tail)
puts "Inserting 'basic' at index #{list.find(list.tail[0])}..."
list.insert_at('basic', list.find(list.tail[0]))

# #test #insert_at (edge case: insert at head)
# puts "Inserting 'basic' at index 0..."
# list.insert_at('basic', 0)

# # test #insert_at (fail: out-of-bounds)
# puts "Inserting 'fortran' at index 100..."
# list.insert_at('basic', 100)

# print and inspect the contents of the list
puts
p list
puts

# test #pop
puts "Popping off the last node: #{list.tail}"
list.pop
list.to_s
puts
p list
puts

# test #remove_at (normal)
puts "Removing node: #{list.at(2)} at index: 2..."
list.remove_at(2)
list.to_s
puts

# # test #remove_at (edge case: head)
# puts "Removing node: #{list.head} at index: 0..."
# list.remove_at(0)
# list.to_s
# puts

# # test #remove_at (edge case: tail)
# puts "Removing node: #{list.tail} at index: #{list.find(list.tail[0])}..."
# list.remove_at(list.find(list.tail[0]))
# list.to_s
# puts

# # test #remove_at (fail: out of bounds)
# puts "Removing node: #{list.at(100)} at index: 100..."
# list.remove_at(100)
# list.to_s
# puts

# final print and inspect
p list
