Rails.application.routes.draw do
  post '/receipts/process', to: 'receipts#create'
end
