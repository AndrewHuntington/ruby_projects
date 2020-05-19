class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data=nil, left=nil, right=nil)
    @data   = data
    @left   = left
    @right  = right
  end

  def <=>(other)
    @data <=> other.data # @data < other.data => -1
  end
end
