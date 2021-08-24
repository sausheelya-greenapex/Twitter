Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "tweets#index"
  get "new/tweet" => "tweets#new"
  post "create/tweet" => "tweets#create"
  get "create/comment" => "tweets#comment"
  get "retweet" => "tweets#retweet"
  post "post/comment" => "tweets#create_comment"
end
