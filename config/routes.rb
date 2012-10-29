Chess960::Application.routes.draw do

get '/startingposition' => 'startingposition#discuss'

get '/startingposition/:spid' => 'startingposition#show', :as => 'show_startingposition'

end
