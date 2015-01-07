class Target < ParseUser

	fields :siteid, :height, :width, :url, :published

  	validates_presence_of :siteid, :url

  	
end