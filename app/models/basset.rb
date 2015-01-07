class Basset < ParseUser

	fields :name, :siteid, :image, :tags, :published

  	validates_presence_of :name, :image #,:siteid

  	
end