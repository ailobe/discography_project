Rails.application.routes.draw do
  root 'welcome#home'
  resources :artists do
    resources :lps, except: :index
    get '/lps', to: 'artists#show_records'
  end
  get '/lps', to: 'lps#index'
end
