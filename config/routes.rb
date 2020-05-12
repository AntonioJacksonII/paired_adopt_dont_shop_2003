Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index'
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'

  get '/shelters/:id', to: 'shelters#show'


  post '/shelters', to: 'shelters#create'
  get '/shelters/:id/edit', to: 'shelters#edit'
  get '/shelters/:shelter_id/pets', to: 'shelter_pets#index'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'
  get '/shelters/:id/pets/new', to: 'pets#new'
  get '/shelters/:shelter_id/pets/:pet_id', to: 'pets#show'

  get '/shelters/:shelter_id/pets/pet_id', to: 'pets#edit'

  get '/shelters/:shelter_id/pets/:pet_id/edit', to: 'shelter_pets#edit'

  post '/shelters/:id/pets', to: 'pets#create'
  get '/pets/:id/edit', to: 'pets#edit'
  get '/pets', to: 'pets#index'
  #get '/shelters/:shelters_id/pets/:pets_id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'

  delete '/pets/:id', to: 'pets#destroy'
  get '/pets/:pet_id', to: 'pets#show'

  get '/shelters/:shelter_id/reviews/new', to: 'reviews#new'
  post '/shelters/:shelter_id', to: 'reviews#create'

  delete '/reviews/:id', to: 'reviews#destroy'

  get '/shelters/:shelter_id/reviews/:review_id/edit', to: 'reviews#edit'
  patch '/reviews/:review_id', to: 'reviews#update'

end
