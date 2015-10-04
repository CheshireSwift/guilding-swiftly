class Numeric

  def copper
    self % 100
  end

  def silver
    (self / 100) % 100
  end

  def gold
    self / (100 * 100)
  end

end

class Price < Struct.new(:low, :high)

  def +(price)
    Price.new(self.low + price.low, self.high + price.high)
  end

  def *(num)
    Price.new(self.low * num, self.high * num)
  end

  def to_s
    "#{Price.pretty_print self.low} - #{Price.pretty_print self.high}"
  end

  def Price.none
    Price.new(0, 0)
  end

  def self.pretty_print(total_copper)
    "#{total_copper.gold}g #{total_copper.silver}s #{total_copper.copper}c"
  end

end

