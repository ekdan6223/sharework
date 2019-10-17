Rails.application.routes.draw do
 
  get 'block/main'
  get 'mypage/main'
  get 'bussiness/index'
  get 'bussiness/location'
  get 'bussiness/change_bs'
  get 'bussiness/create_job'
  get 'bussiness/show_job'
  get 'bussiness/show_applicant'
  post 'bussiness/insertTag'
  post 'bussiness/createJob'
  post 'bussiness/change'
  post 'bussiness/create'
  post 'bussiness/hiredApplication'
  post 'bussiness/add_bussiness_fav'
  get 'mypage/notice_list'
  get 'mypage/terms'
  post 'login/choose/:id' => "login#choose"
  post 'login/kakao_login' => 'login#kakao_login'
  post 'add_information/update/:id' => "add_information#update"
  get 'add_information/add/:id' => "add_information#add"
  get 'albafav/albafavcreate/:id' => "albafav#albafavcreate"
  get 'active/index'
  get 'active/index1'
  get 'active/create_application'
  get 'active/geo_list'
  get 'active/create_favorites'
  get 'active/list_application'
  get 'active/progress_application'
  get 'active/deadline_application'
  post 'active/createApplication'
  post 'active/createFavorites'
  post 'active/selectTag'
  post 'active/appriedCancel'
  get 'users/sessions/localnew'
  get 'devise/sessions/register'
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'users/sessions' }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_scope :user do
    get 'sessions/localnew', :to => 'sessions#localnew'
    
  end
  get 'login/select'
  get 'login/index'
  root 'login#index'
  

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end

