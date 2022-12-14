class ReceiptsController < ApplicationController
  def create
    receipt = Receipt.new(receipt_params)
  end

  private

  def receipt_params
    params.permit(:retailer, :purchase_date, :purchase_time, :total, :short_description, :price, :id, items: [:short_description, :price])
  end
end
