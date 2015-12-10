Rails.application.routes.draw do
  root to: 'parsers#index'

  post 'upload_file' => 'parsers#upload_file'
end
