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
    @vendors.map {|vendor| vendor.items_in_stock.map {|item| item.name}}.flatten.uniq.sort
  end

  # def total_inventory
  #
  # end
end
