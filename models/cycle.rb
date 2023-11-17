class Cycle < ActiveRecord::Base
	has_many :items

	def anchor
		self.title.downcase.split.join("-")
	end

end