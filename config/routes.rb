Rails.application.routes.draw do
  defaults format: :json do
    resources :dns
  end
end
