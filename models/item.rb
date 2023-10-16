class Item < ActiveRecord::Base
	def anchor
		self.title.downcase.split.join("-")
	end
end