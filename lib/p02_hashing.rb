class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    float = 0.0
    each do |el|
      # if el.is_a?(Array)
      #   float += el.hash
      # elsif el.is_a?(Hash)
      #   float += el.hash
      # elsif el.is_a?(String)
      #   float += el.hash
      # else
      #   float += el.hash
      # end
      float += el.hash
    end

    float.to_i
  end
end

class String
  def hash
    byte_seq = self.bytes.reduce{|accum,it| accum = accum.to_f / it.to_f}

    byte_seq.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.keys.hash + self.values.hash
  end
end
