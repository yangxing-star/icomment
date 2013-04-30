Icomment::Application.routes.draw do
  root :to => 'welcome#index'

  match 'welcome/index' => 'welcome#index',      :as => :get
  match 'login' => 'authentications#show',       :as => :login
  match 'sign_in' => 'authentications#create',   :as => :sign_in, :via => :post
  match 'captcha' => 'captcha#simple_captcha',   :as => :captcha, :via => :get

  match 'sign_up' => 'users#new',      :as => :sign_up, :via => :get

  resources :users do
    collection do
      get  :check_session
      get  :signup_login_check
    end
  end

end
