require "./node"

class Tree
  attr :root

  def initialize(array)
    @array = array
  end

  def build_tree
    # Takes an array of data and turns it into a balanced binary tree full Node objects appropriately placed
    # Should return the level-1 root node
  end

  def insert
    #  Accepts a value to insert
  end

  def delete
    # Accepts a value to delete
    # Must deal with several cases such as when a node has children or not
  end

  def find
    # Accepts a value and returns the node with the given value
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
