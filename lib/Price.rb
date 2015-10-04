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
    copper = total_copper % 100
    silver = (total_copper / 100) % 100
    gold = total_copper / (100 * 100)
    "#{gold}g #{silver}s #{copper}c"
  end

end

