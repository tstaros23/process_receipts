class ReceiptsController < ApplicationController
  def show
    # receipt = Rails.cache.fetch("receipts/#{params[:id]}/points", expires_in: 12.hours)
    receipt = Rails.cache.read("#{receipt_params[:id]}")
    receipt2 = Rails.cache.fetch(receipt_params, expires_in: 12.hours) do
      receipt_params[:id] == params[:id]
    end
  end

  def create
    receipt = Receipt.new(receipt_params)
    Rails.cache.write("#{receipt.id}", receipt)
    Rails.cache.read("#{receipt.id}")
    render json: ReceiptSerializer.format_processor(receipt), status: :created
  end


  def receipt_params
    params.permit(:retailer, :purchase_date, :purchase_time, :total, :short_description, :price, :id, items: [:short_description, :price])
  end
end
