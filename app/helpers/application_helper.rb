# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def search_title

  end

	def lower2upper(str)
		str=str.tr('A-z','Ａ-ｚ')
  end
end
