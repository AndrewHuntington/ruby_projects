class Node
  attr_accessor :value, :next_node

  def initialize(value=nil, next_node=nil)
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  attr_accessor :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    # adds a new node containing value to the end of the list
    return prepend(value) if @head.nil?

    node = Node.new(value)

    if !@tail.nil?
      current_tail = @tail
      @tail = node
      current_tail.next_node = @tail
    else
       @tail = node
       @head.next_node = @tail
    end
  end

  def prepend(value)
    # add a new node containing value to the start of the list
     node = Node.new(value)

    if !@head.nil? && !@tail.nil?
      current_head = @head
      @head = node
      @head.next_node = current_head
    elsif !@head.nil? && @tail.nil?
      @tail = @head
      @head = node
      @head.next_node = @tail
    else
      @head = node
    end
  end

  def size
    # returns the total number of nodes in the list
    current_head = @head
    count = 0

    loop do
      count += 1
      current_head = current_head.next_node
      break if current_head.nil?
    end

    count
  end

  def head
    # returns the first node in the list
    @head.value
  end

  def tail
    # returns the last node in the list
    @tail.value
  end

  def at(index)
    # returns the node at the given index (starting from 0)
    return head if index == 0
    return "index is out of bounds" if index > size

    current_head = @head
    count = 0

    while count < index
      current_head = current_head.next_node
      count += 1
    end

    current_head.value
  end

  def pop
    # removes the last element from the list
    current_head = @head

    while current_head.next_node.value != @tail.value
      current_head = current_head.next_node
    end

    @tail = current_head
    @tail.next_node = nil
  end

  def contains?(value)
    # returns true if the passed in value is in the list and otherwise returns false

    current_head = @head

    loop do
      if current_head.value == value
        return true
      end

      current_head = current_head.next_node
      break if current_head.nil?
    end

    false
  end

  def find(value)
    # returns the index of the node containing value, or nil if not found
    current_head = @head
    count = 0

    loop do
      if current_head.value == value
        return count
      end

      current_head = current_head.next_node
      break if current_head.nil?

      count += 1
    end

    nil
  end

  def to_s
    # represents your LinkedList objects as strings, so you can print them out and preview them in the console
    # format: ( value  ) -> ( value ) -> ( value ) -> nil
    current_head = @head

    loop do
      print "( #{current_head.value} ) -> "
      current_head = current_head.next_node
      break if current_head.nil?
    end
    print "nil\n"
  end

  ########## EXTRA CREDIT ##########
  def insert_at(value, index)
    # inserts the node with the provided value at the given index

    # only allow index numbers within range
    return nil if index < 0 || index > size
    return append(value)  if index == size
    return prepend(value) if index == 0

    # update links of nodes in the list after an insertion
   current_head = @head
   count = 0
   node = Node.new(value)

   while count < index
    prev_head = current_head
    current_head = current_head.next_node

    count += 1
   end

   prev_head.next_node = node
   node.next_node = current_head
  end

  def remove_at(index)
    # removes the node at the given index

    # only allow index numbers within range

    # update links of nodes in the list after a removal

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

# test #to_s
list.to_s
puts "----------------"
p list

# test #size
puts "List size is: #{list.size}\n\n"

# #test #head
puts "Head is #{list.head}\n\n"

# #test #tail
puts "Tail is #{list.tail}\n\n"

#test #at
puts "Node at index 1 is #{list.at(1)}\n\n"      # pass
puts "Node at index 100 is #{list.at(100)}\n\n"  # fail

#test #contains?
puts "List contains 'c++': #{list.contains?("c++")}"  # pass
puts "List contains 'pascal': #{list.contains?("pascal")}\n\n" # fail

#test #find?
puts "Found 'ruby' at index: #{list.find("ruby")}"     # pass
puts "Found 'bash' at index: #{list.find("bash")}\n\n" # fail

# test #insert_at (pass: normal)
puts "Inserting 'basic' at index 2..."
list.insert_at('basic', 2)

# test #insert_at (edge case: insert at tail)
puts "Inserting 'swift' at index #{list.find(list.tail)}..."
list.insert_at('swift', list.find(list.tail))

# test #insert_at (edge case: insert at end)
puts "Inserting 'visual basic' at index #{list.find(list.tail)+1}..."
list.insert_at('visual basic', list.find(list.tail)+1)

#test #insert_at (edge case: insert at head)
puts "Inserting 'css' at index 0..."
list.insert_at('css', 0)

# test #insert_at (fail: out-of-bounds)
puts "Inserting 'fortran' at index 100..."
list.insert_at('basic', 100)

# print and inspect the contents of the list
list.to_s
puts
p list
puts

# # test #pop
# puts "Popping off the last node: #{list.tail}"
# list.pop
# list.to_s
# puts
# p list
# puts

# # test #remove_at (normal)
# puts "Removing node: #{list.at(2)} at index: 2..."
# list.remove_at(2)
# list.to_s
# puts

# # # test #remove_at (edge case: head)
# # puts "Removing node: #{list.head} at index: 0..."
# # list.remove_at(0)
# # list.to_s
# # puts

# # # test #remove_at (edge case: tail)
# # puts "Removing node: #{list.tail} at index: #{list.find(list.tail[0])}..."
# # list.remove_at(list.find(list.tail[0]))
# # list.to_s
# # puts

# # # test #remove_at (fail: out of bounds)
# # puts "Removing node: #{list.at(100)} at index: 100..."
# # list.remove_at(100)
# # list.to_s
# # puts

# # final print and inspect
# p list
