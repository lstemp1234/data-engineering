require 'test_helper'

class ImportTest < ActiveSupport::TestCase
  should validate_presence_of(:purchaser_name)
  should validate_presence_of(:item_description)
  should validate_presence_of(:item_price)
  should validate_presence_of(:purchase_count)
  should validate_presence_of(:merchant_address)
  should validate_presence_of(:merchant_name)

  should validate_numericality_of(:item_price).is_greater_than_or_equal_to(0.0)
  should validate_numericality_of(:purchase_count).is_greater_than_or_equal_to(1)

  def setup
    @data = []
    @data << {"purchaser name"=>"Test 1", "item description"=>"Description 1", "item price"=>"10.0", "purchase count"=>"3", "merchant address"=>"Address 1", "merchant name"=>"Name 1"}
    @data << {"purchaser name"=>"Test 2", "item description"=>"Description 2", "item price"=>"20.0", "purchase count"=>"1", "merchant address"=>"Address 2", "merchant name"=>"Name 2"}
  end

  test 'it should calculate gross_revenue' do
    gross_revenue = Import.import_data(@data)
    assert_equal 50.0, gross_revenue
  end
end


