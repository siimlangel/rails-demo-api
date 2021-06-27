Rails.application.routes.draw do
  resources :posts
  resources :posts do
    resources :comments
  end
end
