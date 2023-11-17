require 'sinatra'
require 'sinatra/activerecord'
require 'uri'

require './models/cycle.rb'
require './models/item.rb'
require './models/roadmap.rb'



set :database, {adapter: "sqlite3", database: "app.sqlite3"}
set :bind, "0.0.0.0"
port = ENV["PORT"] || "8080"
set :port, port

get '/' do
	erb :index
end

get '/roadmaps' do
	@roadmaps = Roadmap.all
	erb :roadmap_all
end

get '/roadmaps/new' do
	roadmap = Roadmap.create title: "A roadmap"
	roadmap.create_defaults
	redirect to "roadmaps/#{roadmap.id}"
end

get '/roadmaps/edit/:id' do
	@roadmap = Roadmap.find params[:id]
	erb :roadmap_edit
end

post '/roadmaps/update/:id' do
	title = params[:title]
	roadmap = Roadmap.find params[:id]
	roadmap.update title: title
	redirect to "/roadmaps/#{roadmap.id}"
end

get '/roadmaps/:id' do
	@roadmap = Roadmap.find params[:id]
	@cycles = @roadmap.cycles
	@roadmap.unstale
	erb :roadmap_show
end

get '/items/new' do 
	@item = Item.new roadmap_id: params[:roadmap_id], cycle_id: params[:cycle_id]
	@back_link = "/roadmaps/#{@item.roadmap_id}"
	erb :item_new
end

post '/items/new' do
	cycle_id = params[:cycle_id]
	roadmap_id = params[:roadmap_id]
	title = params[:title]
	description = params[:description]
	important = params[:important]
	item = Item.create cycle_id: cycle_id, roadmap_id: roadmap_id, title: title, description: description, important: important
	redirect to "roadmaps/#{item.roadmap_id}##{item.anchor}"
end

post '/items/update/:id' do
	cycle_id = params[:cycle_id]
	roadmap_id = params[:roadmap_id]
	title = params[:title]
	description = params[:description]
	important = params[:important]
	item = Item.find(params[:id])
	item.update cycle_id: cycle_id, roadmap_id: roadmap_id, title: title, description: description, important: important
	redirect to "/items/#{item.id}"
end

get '/items/edit/:id' do
	@item = Item.find params[:id]
	@back_link = "/items/#{@item.id}"	
	erb :item_edit
end

get '/items/move/:id' do
	@item = Item.find params[:id]
	@item.update cycle_id: params[:destination]
	redirect to "/roadmaps/#{@item.roadmap_id}##{@item.anchor}"
end
	
get '/items/:id' do
	@item = Item.find params[:id]
	@back_link = "/roadmaps/#{@item.roadmap_id}##{@item.anchor}"
	erb :item_show
end
