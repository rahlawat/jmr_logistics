Rails.application.routes.draw do
  devise_for :users
  root to: "entries#index"
  resources :truck_details
  resources :parties
  resources :payment_receipts
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end
  resources :party_invoices, concerns: :paginatable do
    member do
      patch :unlock
      put :unlock
    end
    get 'download', on: :member, to: 'downloads#party_invoice_show'
  end
  resources :entries, concerns: :paginatable do
    resource :download, only: [:show]
    resources :payment_summaries
    resources :bill_entries
    resources :bills
    collection do
      get 'search'
    end
    get 'download', on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
