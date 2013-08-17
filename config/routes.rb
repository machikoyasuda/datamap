Datamap::Application.routes.draw do
  # go to root, at site#index
  root 'site#index'

  # return JSON of line param[:id] data
  get 'line/:id/stats' => 'line#stats', defaults: { format: :json }
end
