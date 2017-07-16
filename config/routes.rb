Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users

  get "inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "sent" => "mailbox#sent", as: :mailbox_sent
  get "trash" => "mailbox#trash", as: :mailbox_trash
  delete "empty_trash" => "mailbox#empty_trash", as: :empty_mailbox_trash

  resources :conversations, only: [:show, :new, :create] do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end

  get '*unmatched_route', to: 'home#unmatched_route'
end
