require_relative 'tree'

bst = Tree.new(Array.new(15) { rand(1..100)})

puts "Tree is balanced: #{bst.balanced?}"
puts "Elements in level order: #{bst.level_order}"
puts "Elements in preorder: #{bst.preorder}"
puts "Elements in inorder: #{bst.inorder}"
puts "Elements in postorder: #{bst.postorder}"

count = 0 

while count < 10
  random_number = rand(100..1000)
  puts "Adding #{random_number} to the tree."
  bst.insert(random_number)
  count += 1
end

puts "Tree is balanced: #{bst.balanced?}"
puts "Balancing tree..."
bst.rebalance!
puts "Tree is balanced: #{bst.balanced?}"

puts "Elements in level order: #{bst.level_order}"
puts "Elements in preorder: #{bst.preorder}"
puts "Elements in inorder: #{bst.inorder}"
puts "Elements in postorder: #{bst.postorder}"