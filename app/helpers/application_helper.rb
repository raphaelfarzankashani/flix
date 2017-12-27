module ApplicationHelper

def title(view)
	content_for(:title, view)
end

def page_title
	if content_for?(:title)
		content_tag(:title,"Movies - #{content_for(:title)}")
	else
		content_tag(:title,"Flix")
	end
end


end