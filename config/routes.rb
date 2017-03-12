Rails.application.routes.draw do
  devise_for :users
  root to: "entries#index"
  resources :entries do
    resource :download, only: [:show]
    resources :payment_summaries
    resources :bill_entries
    collection do
      get 'search'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
