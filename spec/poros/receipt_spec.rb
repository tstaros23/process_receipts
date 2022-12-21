require 'rails_helper'

RSpec.describe Receipt do
  before(:each) do
      attr =
      {
        retailer: "T@rget",
        purchaseDate: "2022-01-01",
        purchaseTime: "13:13",
        total: "1.24",
        items: [
          {shortDescription: "Pepsi - 12-oz e", price: "1.25"},
          {shortDescription: "Coke - 12-ozes", price: "1.25"}
        ]
      }

      attr2 =
      {
        retailer: "Target ",
        purchaseDate: "2022-01-02",
        purchaseTime: "15:13",
        total: "1.00",
        items: [
          {shortDescription: "Pepsi - 12-oz", price: "1.25"}
        ]
      }
      @processed_receipt = Receipt.new(attr)
      @processed_receipt2 = Receipt.new(attr2)
  end
  it "builds receipt attributes" do
    expect(@processed_receipt).to be_an_instance_of(Receipt)

     expect(@processed_receipt.retailer).to eq("T@rget")
     expect(@processed_receipt.retailer.class).to eq(String)

     expect(@processed_receipt.purchaseDate).to eq("2022-01-01")
     expect(@processed_receipt.purchaseDate.class).to eq(String)

     expect(@processed_receipt.total).to eq('1.24')
     expect(@processed_receipt.total.class).to eq(String)

     expect(@processed_receipt.items[0][:shortDescription]).to eq("Pepsi - 12-oz e")
     expect(@processed_receipt.items[0][:shortDescription].class).to eq(String)

     expect(@processed_receipt.items[0][:price]).to eq('1.25')
     expect(@processed_receipt.items[0][:price].class).to eq(String)

     expect(@processed_receipt.id.class).to eq(String)

     expect(@processed_receipt.items).to eq([
       {shortDescription: "Pepsi - 12-oz e", price: "1.25"},
       {shortDescription: "Coke - 12-ozes", price: "1.25"}
     ])
  end

  it "can total alphanumeric characters" do
    expect(@processed_receipt.count_letters).to eq(5)
    expect(@processed_receipt2.count_letters).to eq(6)
  end

  it "can add points if the total is a round dollar amount" do
    expect(@processed_receipt.total_on_the_dollar).to eq(0)
    expect(@processed_receipt2.total_on_the_dollar).to eq(50)
  end

  it "has a total divisible by .25" do
    expect(@processed_receipt.divisible).to eq(0)
    expect(@processed_receipt2.divisible).to eq(25)
  end

  it "can add 5 points for every two items on the receipt" do
    expect(@processed_receipt.add_pairs).to eq(5)
    expect(@processed_receipt2.add_pairs).to eq(0)
  end

  it "can multiply points based on the trimmed short description length" do
    expect(@processed_receipt.trimmed).to eq(1)
    expect(@processed_receipt2.trimmed).to eq(0)
  end

  it "can add  6 points if the date is odd" do
    expect(@processed_receipt.odd_date).to eq(6)
    expect(@processed_receipt2.odd_date).to eq(0)
  end

  it "can add 10 points if the purchase time is in between 2pm and 4pm" do
    expect(@processed_receipt.special_time).to eq(0)
    expect(@processed_receipt2.special_time).to eq(10)
  end
  it "can calculate points" do
    attr3 =
    {
      retailer: "Target",
      purchaseDate: "2022-01-01",
      purchaseTime: "13:01",
      items: [
        {
          shortDescription: "Mountain Dew 12PK",
          price: "6.49"
        },{
          shortDescription: "Emils Cheese Pizza",
          price: "12.25"
        },{
          shortDescription: "Knorr Creamy Chicken",
          price: "1.26"
        },{
          shortDescription: "Doritos Nacho Cheese",
          price: "3.35"
        },{
          shortDescription: "  Klarbrunn 12-PK 12 FL OZ ",
          price: "12.00"
        }
      ],
      total: "35.35"
    }
    attr4 =
    {
      retailer: "M&M Corner Market",
      purchaseDate: "2022-03-20",
      purchaseTime: "14:33",
      items: [
        {
          shortDescription: "Gatorade",
          price: "2.25"
        },{
          shortDescription: "Gatorade",
          price: "2.25"
        },{
          shortDescription: "Gatorade",
          price: "2.25"
        },{
          shortDescription: "Gatorade",
          price: "2.25"
        }
      ],
      total: "9.00"
    }
    receipt3 = Receipt.new(attr3)
    receipt4 = Receipt.new(attr4)

    expect(receipt3.calculate).to eq(28)
    expect(receipt4.calculate).to eq(109)
  end
end
