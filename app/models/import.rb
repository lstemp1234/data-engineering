class Import < ActiveRecord::Base
  validates_presence_of :purchaser_name
  validates_presence_of :item_description
  validates_presence_of :item_price
  validates_presence_of :purchase_count
  validates_presence_of :merchant_address
  validates_presence_of :merchant_name

  validates_numericality_of :item_price,      greater_than_or_equal_to: 0.0
  validates_numericality_of :purchase_count,  greater_than_or_equal_to: 1

  def self.import_data(data)
    gross_revenue = 0.0

    Import.transaction do
      data.each do |row|
        record = {
          purchaser_name:   row['purchaser name'],
          item_description: row['item description'],
          item_price:       row['item price'].to_f,
          purchase_count:   row['purchase count'].to_i,
          merchant_address: row['merchant address'],
          merchant_name:    row['merchant name']
        }

        raise 'Invalid import data' if record[:purchaser_name].blank?

        Import.create(record)
        gross_revenue += record[:item_price] * record[:purchase_count]
      end
    end

    return gross_revenue
  end
end
