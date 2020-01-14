require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor'

class VendorTest < Minitest::Test

  def test_it_exists
    vendor = Vendor.new
    assert_instance_of Vendor, vendor
  end
end
