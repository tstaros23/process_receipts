Rails.application.routes.draw do
  post '/receipts/process', to: 'receipts#create'
  get '/receipts/:id/points', to: 'receipts#show'
end
