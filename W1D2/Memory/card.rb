

class Card

  def ==(other_card)
    @value == other_card.info
  end

  def to_s
    return "X" if @face == :down
    @value
  end

  def reveal
    @face = :up
  end

  def hide
    @face = :down
  end

  def info
    return nil if @face == :down
    @value
  end

  def initialize(value)
    @value = value
    @face = :down
  end

end
