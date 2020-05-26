require "./node"

class Tree
  attr_accessor :root

  def initialize(array)
    # strip out duplicate entries and sort array as per instructions
    @array  = array.uniq.sort
    @root   = build_tree(@array)
  end

  def build_tree(array)
    # Takes an array of data and turns it into a balanced binary tree full Node objects appropriately placed
    # Should return the level-1 root node
    root_element  = (array.length/2).floor
    root = Node.new(array[root_element]) unless array[root_element].nil?
    return root if root_element == 0

    left_array    = array[0..root_element-1]
    right_array   = array[root_element+1..-1]

    root.left  = build_tree(left_array)
    root.right = build_tree(right_array)

    root
  end

  def insert(value)
    #  Accepts a value to insert

    # raise an ArgumentError if bst includes value to keep all values unique
    if @array.include?(value)
      raise ArgumentError, "Sorry, you cannot add duplicate values"
    end 

    # update the array to include new values
    @array.push(value).sort!

    node    = Node.new(value)
    pointer = @root

    loop do
      if node > pointer
        if !pointer.right.nil?
          pointer = pointer.right
        else
          pointer.right = node
          break
        end
      else
        if !pointer.left.nil?
          pointer = pointer.left
        else
          pointer.left = node
          break
        end
      end
    end
  end

  def delete(value)
    # Accepts a value to delete
    # Must deal with several cases such as when a node has children or not
    pointer = @root

    # find the node before the value to be deleted
    if value != pointer.data  # don't run if value == root
      while pointer.left.data != value && pointer.right.data != value
        if value < pointer.data
          pointer = pointer.left
        else
          pointer = pointer.right
        end
      end
    end

    # 3 cases:
    # case 1: leaf node (no child nodes)
    # case 2: node w/1 child
    # case 3: node w/2 children (including root)    
    if pointer.left.data == value && 
      pointer.left.left.nil? && pointer.left.right.nil?         # handle case 1
        pointer.left = nil
    elsif pointer.right.data == value &&
      pointer.right.left.nil? && pointer.right.right.nil?
        pointer.right = nil
    elsif pointer.left.data == value && pointer.left.right.nil? # handle case 2
      pointer.left = pointer.left.left
    elsif pointer.left.data == value && pointer.left.left.nil?
      pointer.left = pointer.left.right
    elsif pointer.right.data == value && pointer.right.right.nil? 
      pointer.right = pointer.right.left
    elsif pointer.right.data == value && pointer.right.left.nil?
      pointer.right = pointer.right.right
    else                                                        # handle case 3
      pointer = find(value)

      right_min = pointer.right

      until right_min.left.nil?
        if right_min > right_min.left
          right_min = right_min.left
        end
      end

      delete(right_min.data)
      pointer.data = right_min.data
    end

    # update the array to include new values
    @array.delete(value)

    self

    # this works, but may not be in the spirit of the challenge...
    # @root = build_tree(@array)
  end

  def find(value)
    # Accepts a value and returns the node with the given value

    # raise an ArgumentError if bst doesn't include value
    if !@array.include?(value)
      raise ArgumentError, "Cannot find value in tree"
    end

    pointer = @root

    # travel the tree to find the node to remove
    while pointer.data != value
      if value < pointer.data
        pointer = pointer.left
      else
        pointer = pointer.right
      end
    end

    pointer
  end

  # breadth-first traversal
  def level_order
    # Returns an array of values in breadth-first level order
  end 


  # depth-first traversal methods

  # DLR
  def preorder
    # Traverses the tree
    # Returns an array of values
  end

  # LDR
  def inorder
    # Traverses the tree
    # Returns an array of values
  end

  #LRD
  def postorder
    # Traverses the tree
    # Returns an array of values
  end

  def depth
    # Accepts a node and returns the depth(number of levels) beneath the node
  end

  def balanced?
    # Checks if the tree is balanced
  end

  def rebalance!
    # Rebalances an unbalanced tree
  end
end

bst = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
