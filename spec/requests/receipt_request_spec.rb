require 'rails_helper'

 RSpec.describe 'Create endpoint' do
   it 'can create a receipt' do
     body = {
       retailer: 'Target',
       purchase_date: "2022-01-02",
       purchase_time: "13.13",
       total: 1.25,
       items: [
         {short_description: "Pepsi - 12-oz", price: 1.25}
       ]
     }

     post '/receipts/process', params: body

     expect(response).to be_successful
     expect(response.status).to eq(201)

     receipt_json = JSON.parse(response.body, symbolize_names: true)
   end
 end
