class MaxIntSet
  def initialize(max)
    @store = Array.new(max) { false }
  end

  def insert(num)
    if is_valid?(num)
      @store[num] = true
    else
      raise "Out of bounds"
    end
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0,@store.length)
  end

  def validate!(num)

  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % @store.length].push(num)
  end

  def remove(num)
    @store[num % @store.length].delete(num)
  end

  def include?(num)
    @store.each do |bucket|
      return true if bucket.include?(num)
    end
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num)
      @store[num % @store.length] << num
      @count += 1
    end
    if @count == @store.length
      resize!
    end
  end

  def remove(num)
    if @store[num % @store.length].delete(num) == num
      @count -= 1
    end
  end

  def include?(num)
    @store[num % @store.length].any? { |el| el == num }
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    store_temp = @store
    @store = Array.new(@store.length * 2) { Array.new }
    @count = 0
    store_temp.each do |bucket|
      bucket.each do |el|
        self.insert(el)
      end
    end
  end
end
