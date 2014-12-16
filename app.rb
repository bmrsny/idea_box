require "./idea"

class IdeaBoxApp < Sinatra::Base
  set :method_override, true

  # configure :development do
  #   register Sinatra::Reloader
  # end

  not_found do
    erb :error
  end

  get '/' do
    erb :index, locals: {ideas: Idea.all} #returns Idea obj array
  end

  post '/' do
    #1 Create an Idea based on params
    idea = Idea.new(params['idea_title'], params['idea_description'])
    # #2 store it
    idea.save
    # #send us back to index to see all
    redirect '/'
  end

  delete '/:id' do |id|
    Idea.delete(id.to_i)
    redirect '/'
  end
end
