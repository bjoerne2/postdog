Rails.application.routes.draw do
  root to: redirect('/inbox')

  devise_for :users

  get "inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "sent" => "mailbox#sent", as: :mailbox_sent
  get "trash" => "mailbox#trash", as: :mailbox_trash
  delete "empty_trash" => "mailbox#empty_trash", as: :empty_mailbox_trash

  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end
end
