require 'rails_helper'

 RSpec.describe 'Create endpoint' do
   it 'can create a receipt' do
     headers = { 'CONTENT_TYPE' => 'application/json', 'Accept' => 'application/json'}

     post '/receipts/process'

     expect(response).to be_successful
     expect(response.status).to eq(201)

     receipt_json = JSON.parse(response.body, symbolize_names: true)
     require "pry"; binding.pry
   end
 end
