require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor'
require './lib/item'

class VendorTest < Minitest::Test

  def setup
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end

  def test_it_exists
    assert_instance_of Vendor, @vendor
  end

  def test_it_has_attributes
    assert_equal "Rocky Mountain Fresh", @vendor.name
    assert_equal ({}), @vendor.inventory
  end

  def test_it_can_check_stock
    assert_equal 0, @vendor.check_stock(@item1)

    @vendor.stock(@item1, 30)

    assert_equal 30, @vendor.check_stock(@item1)

    @vendor.stock(@item1, 25)

    assert_equal 55, @vendor.check_stock(@item1)

    @vendor.stock(@item2, 12)

    assert_equal 12, @vendor.check_stock(@item2)
  end

  def test_it_can_stock_items
    @vendor.stock(@item1, 30)
    expected = {@item1 => 30}

    assert_equal expected, @vendor.inventory

    @vendor.stock(@item1, 25)
    expected = {@item1 => 55}

    assert_equal expected, @vendor.inventory

    @vendor.stock(@item2, 12)
    expected = {@item1 => 55, @item2 => 12}

    assert_equal expected, @vendor.inventory
  end

  def test_it_can_find_items_in_stock
    @vendor.stock(@item1, 30)
    @vendor.stock(@item2, 0)

    assert_equal ({@item1 => 30}), @vendor.items_in_stock
  end

  def test_it_can_determine_if_item_is_short_in_stock
    @vendor.stock(@item1, 35)

    assert_equal true, @vendor.short?(@item1, 36)
    assert_equal false, @vendor.short?(@item1, 35)
    assert_equal false, @vendor.short?(@item1, 34)
  end

  def test_it_can_determine_if_item_is_in_stock
    @vendor.stock(@item1, 35)

    assert_equal true, @vendor.in_stock?(@item1)
    assert_equal false, @vendor.in_stock?(@item2)

    @vendor.stock(@item2, 0)

    assert_equal false, @vendor.in_stock?(@item2)

    @vendor.stock(@item2, 1)

    assert_equal true, @vendor.in_stock?(@item2)
  end

  def test_it_can_sell_items
    @vendor.stock(@item1, 30)

    assert_equal 30, @vendor.check_stock(@item1)
    assert_equal 0, @vendor.sell(@item1, 31)
    assert_equal 30, @vendor.check_stock(@item1)
    assert_equal 29, @vendor.sell(@item1, 29)
    assert_equal 1, @vendor.check_stock(@item1)
  end

  def test_it_can_sell_all_possible
    @vendor.stock(@item1, 30)

    assert_equal 5, @vendor.sell_all_possible(@item1, 5)
    assert_equal 25, @vendor.check_stock(@item1)
    assert_equal 25, @vendor.sell_all_possible(@item1, 500)
    assert_equal 0, @vendor.check_stock(@item1)
  end
end
