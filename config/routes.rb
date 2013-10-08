VaasGit::Application.routes.draw do
  resources :logs

  resources :chef_jsons

  resources :statuses

  resources :machines do
    member do
      get 'toggle'
      get 'provision'
    end
  end

  resources :puppet_options

  resources :puppet_facts

  resources :puppets

  resources :puppet_machines

  resources :networks

  resources :chefs

  resources :boxes

  resources :bashes

  resources :keys

  resources :bash_machines

  resources :chef_machines

  root :to => 'machines#index'
end
