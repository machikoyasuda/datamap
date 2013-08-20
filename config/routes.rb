Datamap::Application.routes.draw do
  # go to root, at site#index
  root 'site#index'

  # get about page
  get '/about',     to: 'site#about'

  # get download page
  get '/download',  to: 'line#download'

  # return JSON of line param[:id] data
  get 'line/:id/stats' => 'line#stats', defaults: { format: :json }
end
