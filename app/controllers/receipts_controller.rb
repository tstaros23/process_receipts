class ReceiptsController < ApplicationController
  def show
    # receipt = Rails.cache.fetch("receipts/#{params[:id]}/points", expires_in: 12.hours)
    receipt = Rails.cache.read("#{receipt_params[:id]}")
    render json: ReceiptSerializer.format_points(receipt), status: :ok
  end

  def create
    receipt = Receipt.new(receipt_params)
    Rails.cache.write("#{receipt.id}", receipt)
    render json: ReceiptSerializer.format_processor(receipt), status: :created
  end


  def receipt_params
    params.permit(:retailer, :purchase_date, :purchase_time, :total, :short_description, :price, :id, items: [:short_description, :price])
  end
end
