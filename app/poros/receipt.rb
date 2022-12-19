require 'securerandom'

class Receipt
  attr_reader :retailer, :purchase_date, :purchase_time, :total, :short_description, :price, :items, :id
  def initialize(attr)
    @retailer = attr[:retailer]
    @purchase_date = attr[:purchase_date]
    @purchase_time = attr[:purchase_time]
    @total = attr[:total]
    @items = attr[:items]
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
    total = @items.count
    pairs = 0
    if @items.count % 2 == 0
      total -= 2
      pairs += 1
    end
    pairs * 5
  end

  def trimmed
    total = 0
    @items.each do |item|
      if item[:short_description].delete(' ').split('').count % 3 == 0
        total += (item[:price] * 0.2).ceil
      end
    end
    total
  end

  def odd_date
    if @purchase_date.delete('-').to_i.odd?
      6
    else
      0
    end
  end
end
