require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test

  def test_it_exists
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    assert_instance_of Item, item2
  end
end
