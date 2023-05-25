class Node
  attr_accessor :data, :left_child, :right_child
  def initialize(data)
    @data = data
    @left_child = left_child
    @right_child = right_child
end

class Tree
  attr_accessor :name
  def initialize(arr)
    @root = root
    @arr = arr
  end

  def build_tree
    #sort array
    #remove duplicates

  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert
    #should traverse the tree and manipulate the nodes and their connections, do not use og array
  end

  def delete(value)
    #should traverse the tree and manipulate the nodes and their connections, do not use og array
  end

  def find(value)
    #returns node with given value
  end

  def level_order
    #accepts a block
    #traverse in breadth-first level order and yield each node to the provided block
    #choose iteration or recursion
    #return array of values if no block given
    #use array actiing as a queue to keep track of all the child nodes that you have yet to traverse and to add new ones to the list
  end

  def inorder
    #method should accept a block
    #traverses tree in respective depth-first order an dyield each node to the provided block
    #should return an array of values if no block given
  end

  def preorder
    #method should accept a block
    #traverses tree in respective depth-first order an dyield each node to the provided block
    #should return an array of values if no block given
  end

  def postorder
    #method should accept a block
    #traverses tree in respective depth-first order an dyield each node to the provided block
    #should return an array of values if no block given
  end

  def height
    #number of edges in longest path from a given node to a leaf node
  end

  def depth
    #Number of edges in path from a given node to the tree's root node
  end

  def balanced?
    #difference between hieghts of left and right subtrees of every node is not more than 1
  end

  def rebalance
    #use traversal method to provide a new array to build_tree method
  end
end