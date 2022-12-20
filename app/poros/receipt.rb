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
      trim = item[:short_description].strip!
      if !trim.nil?
        item[:short_description].strip!.split('').count % 3 == 0
        total += 1
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

  def special_time
    military_time = @purchase_time.split('')[0..1].join.to_i
    if military_time.between?(14, 16)
      10
    else
      0
    end
  end

  def calculate
    points = 0
    points += count_letters + rounded + divisible + add_pairs + trimmed + odd_date + special_time
  end
end
