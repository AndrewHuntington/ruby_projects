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
    pointer = find(value)

    # update the array to include new values
    @array.delete(value)
    
    # 3 cases:
    # leaf node (no child nodes)
    # node w/1 child
    # node w/2 children (including root)


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
    # Accepts a block
    # Traverses the tree in breadth-first level order and yields each node to the provided block
    # Returns an array of values if no block is given
  end


  # depth-first traversal methods
  # look into dynamically declaring the three methods using metaprogamming techniques like #define_method.

  # DLR
  def preorder
    # Accepts a block
    # Traverses the tree in it's respective depth-first order and yields each node to the provided bloc
    # Returns an array of values if no block is given
  end

  # LDR
  def inorder
    # Accepts a block
    # Traverses the tree in it's respective depth-first order and yields each node to the provided block
    # Returns an array of values if no block is given
  end

  #LRD
  def postorder
    # Accepts a block
    # Traverses the tree in it's respective depth-first order and yields each node to the provided block
    # Returns an array of values if no block is given
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
