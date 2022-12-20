class ReceiptSerializer
  def self.format_processor(receipt)
    {"id": receipt.id}
  end

  def self.format_points(receipt)
    {"points": receipt.calculate}
  end
end
