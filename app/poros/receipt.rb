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

  def count_letters
    total = 0
    @retailer.downcase.split('').each do |letter|
      if ('a'..'z').include?(letter)
        total += 1
      end
    end
    total
  end

  def rounded
    if @total.class == Integer
      50
    else
      0
    end
  end

  def divisible
    if @total % 0.25 == 0
      25
    else
      0
    end
  end

  def add_pairs
    require "pry"; binding.pry
  end
end
