class ReceiptsController < ApplicationController
  def show
    receipt = Receipt
  end
  def create
    receipt = Receipt.new(receipt_params)
    render json: ReceiptSerializer.format_processor(receipt), status: :created
  end

  private

  def receipt_params
    params.permit(:retailer, :purchase_date, :purchase_time, :total, :short_description, :price, :id, items: [:short_description, :price])
  end
end
