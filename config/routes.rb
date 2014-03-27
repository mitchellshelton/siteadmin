Siteadmin::Application.routes.draw do
  devise_for :users
  root 'page#index'
  get 'about' => 'page#about'
end