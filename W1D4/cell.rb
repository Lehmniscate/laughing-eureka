class Cell

  attr_accessor :num_adjacent

  def initialize(bomb, revealed=false, flagged=false)
    @bomb = bomb
    @revealed = revealed
    @num_adjacent = 0
    @flagged = flagged
  end

  def bomb?
    @bomb
  end

  def to_s
    return "F" if @flagged
    return " " unless @revealed
    return @num_adjacent.to_s
  end

  def reveal
    @revealed = true
  end

  def revealed?
    @revealed
  end

  def toggle_flag
    @flagged = !@flagged
  end

end
