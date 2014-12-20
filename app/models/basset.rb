class Basset < ParseUser

	fields :name, :siteid, :image

  	validates_presence_of :name, :siteid, :image

  	
end