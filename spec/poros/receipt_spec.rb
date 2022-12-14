require 'rails_helper'

RSpec.describe Receipt do
  it "builds receipt attributes" do
    attr =
    {
      retailer: "Target",
      purchase_date: "2022-01-02",
      purchase_time: "13.13",
      total: 1.25,
      items: [
        {short_description: "Pepsi - 12-oz", price: 1.25}
      ]
    }
    processed_receipt = Receipt.new(attr)
    
    expect(processed_receipt).to be_an_instance_of(Receipt)

     expect(processed_receipt.retailer).to eq("Target")
     expect(processed_receipt.retailer.class).to eq(String)

     expect(processed_receipt.purchase_date).to eq("2022-01-02")
     expect(processed_receipt.purchase_date.class).to eq(String)

     expect(processed_receipt.total).to eq(1.25)
     expect(processed_receipt.total.class).to eq(Float)

     expect(processed_receipt.short_description).to eq("Pepsi - 12-oz")
     expect(processed_receipt.short_description.class).to eq(String)

     expect(processed_receipt.price).to eq(1.25)
     expect(processed_receipt.price.class).to eq(Float)

     expect(processed_receipt.id.class).to eq(String)
  end
end
