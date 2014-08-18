class ExportController < ApplicationController
	def kigyo_out
		content_type = if request.user_agent =~ /windows/i
										 'application/vnd.ms-excel'
									 else
										 'text/csv'
									 end
		CSV::Writer.generate(output = "") do |csv|
			KigyoDaicho.find(:all).each do |kigyo_daicho|
				csv << []
			end
		end
		send_data(output,
							:type => ontent_type,
							:filename => "kigyo.csv")
	end
end
