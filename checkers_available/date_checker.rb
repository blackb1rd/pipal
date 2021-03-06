register_checker("Date_Checker")

class Date_Checker < Checker

	def initialize
		super

		@christian_era_years = {}
		1975.upto(2020) do |year|
			@christian_era_years[year] = 0
		end

		@buddhist_era_years = {}
		2500.upto(2560) do |year|
			@buddhist_era_years[year] = 0
		end

		@days_ab = {'mon' => 0, 'tues' => 0, 'wed' => 0, 'thurs' => 0, 'fri' => 0, 'sat' => 0, 'sun' => 0}
		@months_ab = {"jan" => 0, "feb" => 0, "mar" => 0, "apr" => 0, "may" => 0, "jun" => 0, "jul" => 0, "aug" => 0, "sept" => 0, "oct" => 0, "nov" => 0, "dec" => 0}

		@days = {'monday' => 0, 'tuesday' => 0, 'wednesday' => 0, 'thursday' => 0, 'friday' => 0, 'saturday' => 0, 'sunday' => 0}
		@months = {"january" => 0, "february" => 0, "march" => 0, "april" => 0, "may" => 0, "june" => 0, "july" => 0, "august" => 0, "september" => 0, "october" => 0, "november" => 0, "december" => 0}
		@description = "Days, months, Christian Era years and Buddhist Era years"
	end

	def process_word (word, extras = nil)
		@christian_era_years.each_pair do |year, count|
			if /#{year}/.match word
				@christian_era_years[year] += 1
			end
		end

		@buddhist_era_years.each_pair do |year, count|
			if /#{year}/.match word
				@buddhist_era_years[year] += 1
			end
		end

		@days_ab.each_pair do |day, count|
			if /#{day}/i.match word
				@days_ab[day] += 1
			end
		end

		@months_ab.each_pair do |month, count|
			if /#{month}/i.match word
				@months_ab[month] += 1
			end
		end

		@days.each_pair do |day, count|
			if /#{day}/i.match word
				@days[day] += 1
			end
		end

		@months.each_pair do |month, count|
			if /#{month}/i.match word
				@months[month] += 1
			end
		end
		@total_words_processed += 1
	end

	def get_results()
		ret_str = "Dates\n"

		ret_str << "\nMonths\n"
		disp = false
		@months.each_pair do |month, count|
			unless count == 0
				disp = true
				ret_str << "#{month} = #{count.to_s} (#{((count.to_f/@total_words_processed) * 100).round(2).to_s}%)\n" unless count == 0
			end
		end
		unless disp
			ret_str = "None found\n"
		end

		ret_str << "\nDays\n"
		disp = false
		@days.each_pair do |day, count|
			unless count == 0
				disp = true
				ret_str << "#{day} = #{count.to_s} (#{((count.to_f/@total_words_processed) * 100).round(2).to_s}%)\n" unless count == 0
			end
		end
		unless disp
			ret_str << "None found\n"
		end

		ret_str << "\nMonths (Abreviated)\n"
		disp = false
		@months_ab.each_pair do |month, count|
			unless count == 0
				disp = true
				ret_str << "#{month} = #{count.to_s} (#{((count.to_f/@total_words_processed) * 100).round(2).to_s}%)\n" unless count == 0
			end
		end
		unless disp
			ret_str << "None found\n"
		end

		ret_str << "\nDays (Abreviated)\n"
		disp = false
		@days_ab.each_pair do |day, count|
			unless count == 0
				disp = true
				ret_str << "#{day} = #{count.to_s} (#{((count.to_f/@total_words_processed) * 100).round(2).to_s} %)\n" unless count == 0
			end
		end
		unless disp
			ret_str << "None found\n"
		end

		ret_str << "\nIncludes Christian Era years\n"
		disp = false
		@christian_era_years.each_pair do |number, count|
			unless count == 0
				disp = true
				ret_str << "#{number.to_s} = #{count.to_s} (#{((count.to_f/@total_words_processed) * 100).round(2).to_s}%)\n" unless count == 0
			end
		end
		unless disp
			ret_str << "None found\n"
		end

		ret_str << "\nIncludes Buddhist Era years\n"
		disp = false
		@buddhist_era_years.each_pair do |number, count|
			unless count == 0
				disp = true
				ret_str << "#{number.to_s} = #{count.to_s} (#{((count.to_f/@total_words_processed) * 100).round(2).to_s}%)\n" unless count == 0
			end
		end
		unless disp
			ret_str << "None found\n"
		end

		count_ordered = []
		@christian_era_years.each_pair do |year, count|
			count_ordered << [year, count] unless count == 0
		end
		@christian_era_years = count_ordered.sort do |x,y|
			(x[1] <=> y[1]) * -1
		end

		ret_str << "\nChristian Era Years (Top #{@cap_at.to_s})\n"
		disp = false
		@christian_era_years[0, @cap_at].each do |data|
			disp = true
			ret_str << "#{data[0].to_s} = #{data[1].to_s} (#{((data[1].to_f/@total_words_processed) * 100).round(2).to_s}%)\n"
		end
		unless disp
			ret_str << "None found\n"
		end

		count_ordered = []
		@buddhist_era_years.each_pair do |year, count|
			count_ordered << [year, count] unless count == 0
		end
		@buddhist_era_years = count_ordered.sort do |x,y|
			(x[1] <=> y[1]) * -1
		end

		ret_str << "\nBuddhist Era Years (Top #{@cap_at.to_s})\n"
		disp = false
		@buddhist_era_years[0, @cap_at].each do |data|
			disp = true
			ret_str << "#{data[0].to_s} = #{data[1].to_s} (#{((data[1].to_f/@total_words_processed) * 100).round(2).to_s}%)\n"
		end
		unless disp
			ret_str << "None found\n"
		end

		return ret_str
	end
end
