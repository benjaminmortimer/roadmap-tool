require 'sinatra'
require 'sinatra/activerecord'
require 'uri'

require './models/cycle.rb'
require './models/item.rb'
require './models/roadmap.rb'

set :database, {adapter: "sqlite3", database: "app.sqlite3"}

get '/' do
	erb :index
end

get '/roadmaps' do
	@roadmaps = Roadmap.all
	erb :roadmap_all
end

get '/roadmaps/new' do
	roadmap = Roadmap.create title: "A roadmap"
	now = Cycle.create(title: "Now", roadmap_id: roadmap.id)
	Cycle.create(title: "Next", roadmap_id: roadmap.id)
	Cycle.create(title: "Later", roadmap_id: roadmap.id)
	Item.create(title: "Do something cool!", roadmap_id: roadmap.id, cycle_id: now.id, important: "A first thing on your roadmap")
	redirect to "roadmaps/#{roadmap.id}"
end

get '/roadmaps/:id' do
	@roadmap = Roadmap.find params[:id]
	@cycles = @roadmap.cycles
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