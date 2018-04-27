class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
    # j = 0
    # each do |link|
    #   return link if i == j
    #   j += 1
    # end
    # nil
  end

  def first
    @head.next unless empty?
  end

  def last
    @tail.prev unless empty?
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
    val = nil
    self.each {|node| val = node.val if node.key == key }
    val
  end

  def include?(key)
    return_result = false
    self.each { |node| return_result = true if node.key == key }
    return_result
  end

  def append(key, val)
    node = Node.new(key,val)
    previous_obj = @tail.prev
    previous_obj.next = node
    node.prev = previous_obj
    node.next = @tail
    @tail.prev = node
  end

  def update(key, val)
    self.each { |node| node.val = val if node.val != nil && node.key == key }
  end

  def remove(key)
    if include?(key)
      node_to_remove = nil
      self.each { |node| node_to_remove = node if node.key == key }
      previous_node = node_to_remove.prev
      next_node = node_to_remove.next
      previous_node.next = next_node
      next_node.prev = previous_node
      node_to_remove.next = nil
      node_to_remove.prev = nil
    end
  end

  def each(&prc)
    return nil if empty?
    node = first

    until node == @tail
      prc.call(node)
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
