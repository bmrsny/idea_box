require "./idea"

class IdeaBoxApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  not_found do
    erb :error
  end

  get '/' do
    erb :index
  end

  post '/' do
    params.inspect
    idea = Idea.new(params['idea_title'], params['idea_description'])
    # #2 store it
    idea.save
    # #send us back to index to see all
    "Creating an Idea"
  end
end
