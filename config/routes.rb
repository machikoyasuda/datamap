Datamap::Application.routes.draw do
  get "line/stats"
  root 'site#index'
  get 'line/:id/stats' => 'line#stats'
end
