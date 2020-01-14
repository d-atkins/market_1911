class Vendor
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    @inventory[item]
  end

  def stock(item, amount)
    @inventory[item] += amount
  end

  def items_in_stock
    @inventory.reduce({}) do |acc, (item, amount)|
      acc[item] = amount if amount > 0
      acc
    end
  end
end
