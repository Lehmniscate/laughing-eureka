class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    # return 0 if empty?
    flatten.join.to_i ^ flatten.sort.join.to_i + length
  end
end

class String
  def hash
    split("").map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    keys.hash
  end
end
