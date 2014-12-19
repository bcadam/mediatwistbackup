class Site < ParseUser

	fields :title, :url, :body

  	validates_presence_of :title, :url, :userid
end