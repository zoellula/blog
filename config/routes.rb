Rails.application.routes.draw do
  devise_for :users
  #, controllers: { sessions: 'users/sessions' }

  resources :articles do
	  resources :comments
	end

	resources :payments do
		collection do
			post  :pay
		end
	end


	root 'welcome#index'
end

