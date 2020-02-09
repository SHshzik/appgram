Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :rooms do
        resources :messages
      end
      resources :users
    end
  end
end
