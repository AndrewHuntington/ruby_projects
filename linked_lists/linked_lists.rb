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
  end

  def size
    # returns the total number of nodes in the list
    @list.length
  end

  def head
    # returns the first node in the list
  end

  def tail
    # returns the last node in the list
  end

  def at(index)
    # returns the node at the given index
  end

  def pop
    # removes the last element from the list
  end

  def contains?(value)
    # returns true if the passed in value is in the list and otherwise returns false
    false
  end

  def find(value)
    # returns the index of the node containing value, or nil if not found
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
  end

  def remove_at(index)
    # removes the node at the given index
    # note: need to update links of nodes in the list after a removal
  end
end

list = LinkedList.new

# test #append
list.append("ruby")
list.append("javascript")
list.append("c++")

# test #t0_s
list.to_s

# test #size
puts "List size is: #{list.size}\n\n"

# print and inspect the contents of the list
p list