Rails.application.routes.draw do
  root 'welcome#index'
  resources :artists do
    resources :lps, except: :index
    get '/lps', to: 'artists#show_records'
  end
  get '/lps', to: 'lps#index'
  post '/lps', to: 'lps#create'
end
