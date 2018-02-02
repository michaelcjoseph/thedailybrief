Rails.application.routes.draw do
  match '*all', to: 'application#preflight', via: [:options]
  root to: 'application#show'

  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth'
    post '/users/:id/:email_status' => 'user_settings#update_email_status'
    post '/users/:id/books/:status' => 'user_settings#update_books_status'
    post '/users/:id/topics/:topic_id/' => 'user_settings#update_topic_status'
    
    get '/articles' => 'articles#index'
    get '/articles/:id' => 'articles#show_article'
    post '/articles/:id' => 'articles#update_views'
    post '/articles/:id/:topic_id/:type' => 'articles#update_topic'

    get '/podcasts' => 'podcasts#index'
    get '/podcasts/:id' => 'podcasts#show_podcast'
    post '/podcasts/:id' => 'podcasts#update_views'
    post '/podcasts/:id/:topic_id/:type' => 'podcasts#update_topic'

    get '/books' => 'books#index'
    post '/books/:id/:button' => 'books#update_views'
    post '/books/:id/:topic_id/:type' => 'books#update_topic'

    get '/topics' => 'topics#index'
    get '/subtopics' => 'subtopics#index'
  end

  get '*path', to: 'application#show'
end
