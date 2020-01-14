class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map {|vendor| vendor.name}
  end

  def vendors_that_sell(item)
    @vendors.find_all {|vendor| vendor.check_stock(item) > 0}
  end

  def items_by_vendor
    @vendors.reduce({}) do |acc, vendor|
      acc[vendor] = vendor.items_in_stock
      acc
    end
  end

  def sorted_item_list
    items_by_vendor.values.map do |items|
      items.keys.map {|item| item.name}
    end.flatten.uniq.sort
  end

  def total_inventory
    items_by_vendor.reduce(Hash.new(0)) do |acc, (vendor, items)|
      items.each {|item, amount| acc[item] += amount}
      acc
    end
  end

  def sell(item, amount)
    return false if total_inventory[item] < amount
    @vendors.each
    true
  end
end
