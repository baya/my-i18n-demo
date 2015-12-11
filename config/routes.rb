Rails.application.routes.draw do
  
  namespace :admin do
    resources :translation_files
  end
  
end
