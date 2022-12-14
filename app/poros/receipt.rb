require 'securerandom'

class Receipt
  attr_reader :retailer, :purchase_date, :purchase_time, :total, :short_description, :price, :id
  def initialize(attr)
    @retailer = attr[:retailer]
    @purchase_date = attr[:purchase_date]
    @purchase_time = attr[:purchase_time]
    @total = attr[:total]
    @short_description = attr[:items][0][:short_description]
    @price = attr[:items][0][:price]
    @id = SecureRandom.hex
  end
end
