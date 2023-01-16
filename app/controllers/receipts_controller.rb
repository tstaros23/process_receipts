class ReceiptsController < ApplicationController
  def show
    receipt = Rails.cache.read("#{receipt_params[:id]}")
    if receipt.nil?
      render json: {errors: {details: "Invalid ID"}}, status: :not_found
    else
      render json: ReceiptSerializer.format_points(receipt), status: :ok
    end
  end

  def create
    receipt = Receipt.new(receipt_params)
    if receipt.valid?
      Rails.cache.write("#{receipt.id}", receipt)
      render json: ReceiptSerializer.format_processor(receipt), status: :created
    else
      render json: {errors: {details: "Invalid ID"}}, status: :bad_request
    end
  end


  def receipt_params
    params.permit(:retailer, :purchaseDate, :purchaseTime, :total, :shortDescription, :price, :id, items: [:shortDescription, :price])
  end
end
