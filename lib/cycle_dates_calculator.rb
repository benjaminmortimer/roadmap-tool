class CycleDatesCalculator

	def first_reasonable_thursday(year)
		day = Time.new(year, 1, 8)
		until day.thursday? do
			day += (60 * 60 * 24)
		end
		day
	end

	def last_reasonable_wednesday(year)
		day = Time.new(year, 12, 18)
		until day.wednesday? do
			day -= (60 * 60 * 24)
		end
		day
	end

	def eighth_dates(start_date)
		end_date = start_date + (60 * 60 * 24 * 7 * 6) - (60 * 60 * 24)
		Range.new(start_date, end_date)
	end

	def eighths(year)
		eighths = []
		eighths.push(eighth_dates(first_reasonable_thursday(year)))
		7.times do
			eighths.push(eighth_dates(eighths.last.last + (60 * 60 * 24)))
		end
		eighths
	end

	def current
		now = Time.now
		eighths = eighths(now.year)
		eighths.each do |eighth|
			return eighth if eighth.include? now
		end
	end

	def next_eighth(from)
		unless from.last == last_reasonable_wednesday(from.last.year)
			eighth_dates(from.last + (60 * 60 * 24))
		else
			eighth_dates(first_reasonable_thursday(from.last.year + 1))
		end
	end

	def pretty_date_to_time_object(pretty_date)
		months = [nil, "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
		date_components = pretty_date.split(" ")
		puts date_components
		day = date_components[0]
		month = months.index(date_components[1])
		year = date_components[2]
		Time.new(year, month, day)
	end
			
end

cdc = CycleDatesCalculator.new
puts cdc.first_reasonable_thursday(2023)
puts cdc.last_reasonable_wednesday(2023)
puts cdc.eighth_dates(cdc.first_reasonable_thursday(2023))
puts "--"
puts cdc.eighths(2023)
puts "--"
puts cdc.current
puts cdc.next_eighth(cdc.current)
puts "--"
puts cdc.current.first
puts cdc.pretty_date_to_time_object("1 January 2023")