class Basset < ParseUser

	fields :name, :siteid, :image, :tags

  	validates_presence_of :name, :siteid, :image

  	
end