require 'rails_helper'

RSpec.describe Receipt do
  before(:each) do
      attr =
      {
        retailer: "T@rget",
        purchase_date: "2022-01-02",
        purchase_time: "13.13",
        total: 1.24,
        items: [
          {short_description: "Pepsi - 12-oz", price: 1.25},
          {short_description: "Coke - 12-oz", price: 1.25}
        ]
      }
      @processed_receipt = Receipt.new(attr)

      attr =
      {
        retailer: "Target ",
        purchase_date: "2022-01-02",
        purchase_time: "13.13",
        total: 1,
        items: [
          {short_description: "Pepsi - 12-oz", price: 1.25}
        ]
      }
      @processed_receipt2 = Receipt.new(attr)
  end
  it "builds recipt attributes" do
    expect(@processed_receipt).to be_an_instance_of(Receipt)

     expect(@processed_receipt.retailer).to eq("T@rget")
     expect(@processed_receipt.retailer.class).to eq(String)

     expect(@processed_receipt.purchase_date).to eq("2022-01-02")
     expect(@processed_receipt.purchase_date.class).to eq(String)

     expect(@processed_receipt.total).to eq(1.24)
     expect(@processed_receipt.total.class).to eq(Float)

     expect(@processed_receipt.short_description).to eq("Pepsi - 12-oz")
     expect(@processed_receipt.short_description.class).to eq(String)

     expect(@processed_receipt.price).to eq(1.25)
     expect(@processed_receipt.price.class).to eq(Float)

     expect(@processed_receipt.id.class).to eq(String)
  end

  it "can total alphanumeric characters" do
    expect(@processed_receipt.count_letters).to eq(5)
    expect(@processed_receipt2.count_letters).to eq(6)
  end

  it "can add points if the total is a round dollar amount" do
    expect(@processed_receipt.rounded).to eq(0)
    expect(@processed_receipt2.rounded).to eq(50)
  end

  it "has a total divisible by .25" do
    expect(@processed_receipt.divisible).to eq(0)
    expect(@processed_receipt2.divisible).to eq(25)
  end

  it "can add 5 points for every two items on the receipt" do
    expect(@processed_receipt.add_pairs).to eq(5)
    expect(@processed_receipt2.add_pairs).to eq(0)
  end
end
