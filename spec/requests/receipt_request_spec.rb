require 'rails_helper'

 RSpec.describe 'Create endpoint' do
   it 'can create a receipt and look up the object by id' do
     body = {
       retailer: 'Target',
       purchaseDate: "2022-01-02",
       purchaseTime: "13:13",
       total: "1.25",
       items: [
         {shortDescription: "Pepsi - 12-oz", price: "1.25"}
       ]
     }

     post '/receipts/process', params: body
     expect(response).to be_successful
     expect(response.status).to eq(201)

     receipt_json = JSON.parse(response.body, symbolize_names: true)
     expect(receipt_json).to have_key(:id)

     get "/receipts/#{receipt_json[:id]}/points"

     expect(response).to be_successful
     expect(response.status).to eq(200)

     get_data = JSON.parse(response.body, symbolize_names: true)
     expect(get_data[:points]).to eq(31)
   end
 end
