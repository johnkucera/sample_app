module ApplicationHelper
  $appName="ETrade RSU Helper"
  def full_title(page_title)
  	base_title=$appName
  	if page_title.empty?
  		base_title
  	else
  		"#{page_title}"
  	end
  end
end
