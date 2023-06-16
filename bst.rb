class Node
  attr_accessor :data, :left, :right

  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end

class Tree
  attr_accessor :name

  def initialize(arr)
    @root = build_tree(arr)
  end

  def build_tree(arr)
    return nil if arr.empty?

    clean_arr = arr.sort.uniq
    root_index = clean_arr.size / 2
    root_data = clean_arr[root_index]
    left_subtree = build_tree(clean_arr[0...root_index])
    right_subtree = build_tree(clean_arr[root_index + 1..-1])

    return Node.new(root_data, left_subtree, right_subtree)
  end
  


  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value)
    #should traverse the tree and manipulate the nodes and their connections, do not use og array
    @root = insert_recursive(@root, value)
  end

  def insert_recursive(node, value)
    return Node.new(value) if node.nil?

    if value < node.data
      node.left = insert_recursive(node.left, value)
    elsif value > node.data
      node.right = insert_recursive(node.right, value)
    end

    node
  end

  def delete(value)
    #should traverse the tree and manipulate the nodes and their connections, do not use og array
    @root = delete_recursive(@root, value)
  end

  def delete_recursive(node,value)
    return node if node.nil?

    if value < node.data
      node.left = delete_recursive(node.left, value)
    elsif value > node.data
      node.right = delete_recursive(node.right, value)
    else
      #case 1: Deleted node has no children :(
      if node.left.nil? && node.right.nil?
        node = nil
      #case 2: Deleted node only has one child (right)
      elsif node.left.nil?
        node = node.right
      #case 3: Deleted node only has one child (left)
      elsif node.right.nil? 
        node = node.left
      #case 4: Deleted node has two children
      else
        #Find minimum value node in right subtree (successor)
        successor = find_minimum(node.right)
        #replace the node data with successor data
        node.data = successor.data
        #Delete the successor node recursively from the right subtree
        node.right = delete_recursive(node.right, successor.data)
      end
    end
    
    node
  end

  def find_minimum(node)
    current = node
    while current.left
      current = current.left
    end
    current
  end


  end

  def find(value)
    #returns node with given value
    current = @root

    while current
      if value == current.data
        return current
      elsif value < current.data
        current = current.left
      else
        current = current.right
      end
    end

    return nil
    puts "#{value} could not be found within this tree."
  end

  def level_order(&block)
    return [] unless @root

    result = []
    queue = [@root]

    while !queue.empty?
      node = queue.shift
      yield node if block_given?
      result << node.data

      queue << node.left if node.left
      queue << node.right if node.right
    end

    result
  end

  def inorder(&block)
    return [] unless @root

    result = []
    stack = []
    node = @root

    while !stack.empty? || !node.nil?
      if !node.nil?
        stack.push(node)
        node = node.left
      else
        node = stack.pop
        block_given? ? yield(node.data) : result << node.data
        node = node.right
      end
    end
    result
    #left subtree, current node, right subtree
    #method should accept a block
    #traverses tree in respective depth-first order and yield each node to the provided block
    #should return an array of values if no block given
  end

  def preorder(&block)
    return [] unless @root

    result = []
    node = @root
    stack = []
    

    while !stack.empty? || !node.nil?
      if !node.nil?
        yield node.data if block_given?
        result << node.data unless block_given?
        stack << node
        node = node.left
      else
        node = stack.pop
        node = node.right
      end
    end

    result
    #current node, left subtree, right subtree
    #method should accept a block
    #traverses tree in respective depth-first order and yield each node to the provided block
    #should return an array of values if no block given
  end

  def postorder(&block)
    postorder_recursive(@root, &block)
  end

  def postorder_recursive(node, &block)
    return [] if node.nil?

    result = []
    result.concat(postorder_recursive(node.left, &block))
    result.concat(postorder_recursive(node.right, &block))
    result << node.data if block_given?
    result
    #left subtree, right subtree, current node
    #method should accept a block
    #traverses tree in respective depth-first order and yield each node to the provided block
    #should return an array of values if no block given
  end

  def height(node)
    return nil if node.nil?

    l_height = height(node.left)
    r_height = height(node.right)
    return max(l_height, r_height) + 1
    #number of edges in longest path from a given node to a leaf node

  end

  def depth(node)
    #Number of edges in path from a given node to the tree's root node
    return nil if node.nil? || node == @root

    current = @root
    depth = 0

    while current != node
      if node.data < current.data
        current = current.left
      else
        current = current.right
      end

      depth += 1
  end

  def balanced?(node = @root)
    #difference between heights of left and right subtrees of every node is not more than 1
    return nil if @root.nil?

    l_height = height(node.left)
    r_height = height(node.right)

    if (l_height - r_height).abs > 1
      puts "Not balanced"
      return false
    end

    balanced?(node.left) && balanced?(node.right)

  end

  def rebalance
    #use a traversal method to provide a new array to build_tree method
    new_tree = []
    inorder(|node| node.value >> new_tree )
    new_tree.sort.uniq
    @root = build_tree(new_tree)
  end
end