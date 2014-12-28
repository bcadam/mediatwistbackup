class Target < ParseUser

	fields :siteid, :height, :width, :url

  	validates_presence_of :siteid, :url

  	
end