class LinkedList
  def append(value)
    # adds a new node containing value to the end of the list
  end

  def prepend(value)
    # add a new node containing value to the start of the list
  end

  def size
    # returns the total number of nodes in the list
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

class Node
  attr_accessor :value, :node

  def initialize(value, next_node)
    @value = nil
    @next_node = nil
  end
end
