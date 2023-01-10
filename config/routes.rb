Rails.application.routes.draw do

  # get "/assignments", to: "assignments#index"
  root to: 'assignments#index'
  get "/:short_url", to: "assignments#show"
  get "shortened/:short_url", to: "assignments#shortened", as: :shortened
  post "/assignments/create"
  get "/assignments/fetch_original_url"
  # get '/assignments/index' 
  # root :to => "assignments#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
