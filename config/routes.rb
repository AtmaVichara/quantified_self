Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :foods
      resources :meals, except: [:show]
      get '/meals/:id/foods', to: 'meals#show'
      post "/meals/:meal_id/foods/:id", to: "meals#create"
      delete "/meals/:meal_id/foods/:id", to: "meals#destroy"
    end
  end
end
