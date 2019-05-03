Rails.application.routes.draw do
  devise_for :users
  root to: "entries#index"
  resources :truck_details
  resources :payment_receipts
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end
  resources :parties, concerns: :paginatable do
    resources :opening_balances
  end
  get 'parties/party_by_code/:party_code', to: 'parties#party_by_code'
  resources :party_invoices, concerns: :paginatable do
    member do
      patch :unlock
      put :unlock
    end
    resources :bills
    get 'download', on: :member, to: 'downloads#party_invoice_show'
  end
  get 'download_statement', to: 'downloads#invoice_statement_show'
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
