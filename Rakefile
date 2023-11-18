require 'sinatra/activerecord/rake'
require 'kramdown'

namespace :db do
	task :load_config do
		require './app'
	end
end

namespace :markdown do
	desc 'Creates an erb partial from the statement markdown file'
	task :render_statement do
		origin = File.read("./source/statement.md")
		destination = File.open("./views/_statement_content.erb", "w")
		destination.write(Kramdown::Document.new(origin).to_html)
	end
	task :render_statement_summary do
		origin = File.read("./source/statement_summary.md")
		destination = File.open("./views/_statement_summary_content.erb", "w")
		destination.write(Kramdown::Document.new(origin).to_html)
	end
end