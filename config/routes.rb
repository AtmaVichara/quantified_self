Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :foods
      resources :meals, only: [:index]
      namespace :meals, path: 'meals/:meal_id' do
        resources :foods, only: [:index]
        post '/foods/:id', to: 'foods#create'
        delete '/foods/:id', to: 'foods#destroy'
      end
    end
  end
end
