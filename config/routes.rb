Rails.application.routes.draw do
  post '/send_otp_code', as: 'user_send_otp_code', to: 'users#send_code'
  resources :users, only: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
