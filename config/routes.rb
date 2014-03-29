Siteadmin::Application.routes.draw do
  resources :contents

  devise_for :users
  root 'page#index'
  get 'about' => 'page#about'
end