require './lib/cycle_dates_calculator.rb'

class Roadmap < ActiveRecord::Base
	has_many :cycles

	def create_defaults
		calc = CycleDatesCalculator.new
		now = Cycle.create(title: "Now", roadmap_id: self.id, start_date: calc.current.first.strftime("%-d %B %Y"), end_date:calc.current.last.strftime("%-d %B %Y"))
		Cycle.create(title: "Next", roadmap_id: self.id, start_date: calc.next_eighth(calc.current).first.strftime("%-d %B %Y"), end_date: calc.next_eighth(calc.current).last.strftime("%-d %B %Y"))
		Cycle.create(title: "Later", roadmap_id: self.id)
		Item.create(title: "Do something cool!", roadmap_id: self.id, cycle_id: now.id, important: "A first thing on your roadmap")
	end

	def bump_cycle_dates
		calc = CycleDatesCalculator.new
		self.cycles.first.update(start_date: calc.current.first.strftime("%-d %B %Y"), end_date:calc.current.last.strftime("%-d %B %Y"))
		self.cycles[1].update(start_date: calc.next_eighth(calc.current).first.strftime("%-d %B %Y"), end_date: calc.next_eighth(calc.current).last.strftime("%-d %B %Y"))
	end

	def unstale
		calc = CycleDatesCalculator.new
		if Time.now > calc.pretty_date_to_time_object(self.cycles.first.end_date)
			bump_cycle_dates
		end
	end

end

