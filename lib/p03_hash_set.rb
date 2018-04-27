require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless include?(key)
      @store[key.hash % @store.length].push(key)
      @count += 1
    end
    resize! if @count == @store.length
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  def remove(key)
    if include?(key)
      @store[key.hash % @store.length].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @store.length]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp_arr = @store
    @store = Array.new(temp_arr * 2) {Array.new}
    @count = 0
    temp_arr.each do |bucket|
      bucket.each do |el|
        self.insert(el)
      end
    end
  end
end
