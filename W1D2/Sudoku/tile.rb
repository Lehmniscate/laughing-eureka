class Tile
  attr_reader :value

  def value=(value)
    @value = value unless @given
  end

  def initialize(value)
    @value = value
    @given = value == 0 ? false : true
  end

  def to_s
    @value == 0 ? " " : @value.to_s
  end

end
