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
    @inventory[item] += amount if item.class == Item
  end

  def items_in_stock
    @inventory.reduce({}) do |acc, (item, amount)|
      acc[item] = amount if in_stock?(item)
      acc
    end
  end

  def short?(item, amount)
    check_stock(item) < amount
  end

  def in_stock?(item)
    check_stock(item) > 0
  end

  def sell(item, amount)
    if check_stock(item) >= amount
      @inventory[item] -= amount
      amount
    else
      0
    end
  end

  def sell_all_possible(item, amount)
    if short?(item, amount)
      sell(item, @inventory[item])
    else
      sell(item, amount)
    end
  end
end
