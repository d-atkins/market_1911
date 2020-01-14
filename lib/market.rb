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

  def sorted_item_list
    # item_history = @vendors.map {|vendor| vendor.inventory}
    # items_in_stock = item_history.map do |items|
    #   items.find_all do |item, amount|
    #     amount >= 0
    #     require "pry"; binding.pry
    #   end
    # end

    @vendors.map {|vendor| vendor.items_in_stock.map {|item| item.name}}.flatten.uniq.sort
  end
end
