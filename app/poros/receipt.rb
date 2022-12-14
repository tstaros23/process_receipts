require 'securerandom'

class Receipt
  attr_reader :retailer, :purchaseDate, :purchaseTime, :total, :shortDescription, :price, :items, :id
  def initialize(attr)
    @retailer = attr[:retailer]
    @purchaseDate = attr[:purchaseDate]
    @purchaseTime = attr[:purchaseTime]
    @total = attr[:total]
    @items = attr[:items]
    @id = SecureRandom.hex
  end

  def count_letters
    total = 0
    @retailer.downcase.split('').each do |char|
      if char.ord.between?(48, 59) || char.ord.between?(97,122)
        total += 1
      end
    end
    total
  end

  def total_on_the_dollar
    if @total.to_f.ceil > @total.to_f
      0
    else
      50
    end
  end

  def divisible
    if @total.to_f % 0.25 == 0
      25
    else
      0
    end
  end

  def add_pairs
    total = @items.count
    pairs = 0
    while total > 1 do
        pairs += 1
        total -= 2
    end
    pairs * 5
  end

  def trimmed
    total = 0
    @items.each do |item|
      trim = item[:shortDescription].strip
      if trim.length % 3 == 0
        item[:shortDescription]
        result = (item[:price].to_f * 0.2).ceil
        total += result
      end
    end
    total
  end

  def odd_date
    if @purchaseDate.delete('-').to_i.odd?
      6
    else
      0
    end
  end

  def special_time
    military_time = @purchaseTime.split('')[0..1].join.to_i
    if military_time >= 14 && military_time < 16
      10
    else
      0
    end
  end

  def calculate
    points = 0
    points += count_letters + total_on_the_dollar + divisible + add_pairs + trimmed + odd_date + special_time
  end
end
