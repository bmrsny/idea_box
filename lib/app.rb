# require "./idea"
# require "./idea_store"
require 'time'
require 'idea_box'
class IdeaBoxApp < Sinatra::Base
  set :method_override, true
  set :root, 'lib/app'

  # register Sinatra::Partial
  # set: partial_template_engine, :erb

  not_found do
    erb :error
  end

  get '/' do
    erb :index, locals: {ideas: IdeaStore.all.sort, idea: Idea.new(params)}
  end

  post '/' do
    IdeaStore.create(params[:idea], Time.now)
    redirect '/'
  end

  get '/filter/:tag' do
    erb :index, locals: {ideas: IdeaStore.filter(params[:tag]), idea: Idea.new(params)}
  end

  delete '/:id' do |id|
    IdeaStore.delete(id.to_i)
    redirect '/'
  end

  get '/:id/edit' do |id|
    idea = IdeaStore.find(id.to_i)
    erb :edit, locals: {idea: idea}
  end

  put '/:id' do |id|
    IdeaStore.update(id.to_i, params[:idea])
    redirect '/'
  end

  post '/:id/like' do |id|
    idea = IdeaStore.find(id.to_i)
    idea.like!
    IdeaStore.update(id.to_i, idea.to_h)
    redirect '/'
  end

  # helpers do
  #   def shout(words)
  #     words.upcase
  #   end
  # end

  # get '/playground' do
  #   @things = [
  #     {name: 'Thumb', desc: "Face"},
  #     {name: "Smelly", desc: "What was that???!"}
  #   ]
  #   @adjective = ["nice", "decent", "extremely stressed", "cruddy"].shuffle.first
  #   erb :playground
  # end
end
