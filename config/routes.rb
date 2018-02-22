Rails.application.routes.draw do
  resources :weathers do 
  	collection do
  	  post :searched
  	end
  end

  root 'weathers#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
