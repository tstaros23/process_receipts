require 'rails_helper'

RSpec.describe Receipt do
  before(:each) do
      attr =
      {
        retailer: "T@rget",
        purchase_date: "2022-01-01",
        purchase_time: "13:13",
        total: "1.24",
        items: [
          {short_description: "Pepsi - 12-oz e", price: "1.25"},
          {short_description: "Coke - 12-ozes", price: "1.25"}
        ]
      }

      attr2 =
      {
        retailer: "Target ",
        purchase_date: "2022-01-02",
        purchase_time: "15:13",
        total: "1.00",
        items: [
          {short_description: "Pepsi - 12-oz", price: "1.25"}
        ]
      }
      @processed_receipt = Receipt.new(attr)
      @processed_receipt2 = Receipt.new(attr2)
  end
  it "builds receipt attributes" do
    expect(@processed_receipt).to be_an_instance_of(Receipt)

     expect(@processed_receipt.retailer).to eq("T@rget")
     expect(@processed_receipt.retailer.class).to eq(String)

     expect(@processed_receipt.purchase_date).to eq("2022-01-01")
     expect(@processed_receipt.purchase_date.class).to eq(String)

     expect(@processed_receipt.total).to eq('1.24')
     expect(@processed_receipt.total.class).to eq(String)

     expect(@processed_receipt.items[0][:short_description]).to eq("Pepsi - 12-oz e")
     expect(@processed_receipt.items[0][:short_description].class).to eq(String)

     expect(@processed_receipt.items[0][:price]).to eq('1.25')
     expect(@processed_receipt.items[0][:price].class).to eq(String)

     expect(@processed_receipt.id.class).to eq(String)

     expect(@processed_receipt.items).to eq([
       {short_description: "Pepsi - 12-oz e", price: "1.25"},
       {short_description: "Coke - 12-ozes", price: "1.25"}
     ])
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
      purchase_date: "2022-01-01",
      purchase_time: "13:01",
      items: [
        {
          short_description: "Mountain Dew 12PK",
          price: "6.49"
        },{
          short_description: "Emils Cheese Pizza",
          price: "12.25"
        },{
          short_description: "Knorr Creamy Chicken",
          price: "1.26"
        },{
          short_description: "Doritos Nacho Cheese",
          price: "3.35"
        },{
          short_description: "  Klarbrunn 12-PK 12 FL OZ ",
          price: "12.00"
        }
      ],
      total: "35.35"
    }
    attr4 =
    {
      retailer: "M&M Corner Market",
      purchase_date: "2022-03-20",
      purchase_time: "14:33",
      items: [
        {
          short_description: "Gatorade",
          price: "2.25"
        },{
          short_description: "Gatorade",
          price: "2.25"
        },{
          short_description: "Gatorade",
          price: "2.25"
        },{
          short_description: "Gatorade",
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
