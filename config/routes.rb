Rails.application.routes.draw do
  root 'lists#index'  # <-- Add this line

  resources :lists, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :bookmarks, only: [:new, :create]
    resources :reviews, only: [:create]
  end

  resources :bookmarks, only: :destroy
end
