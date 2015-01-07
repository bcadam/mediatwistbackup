class Site < ParseUser

	fields :title, :url, :body, :userid, :image, :imageinfo, :siteassets, :published


  	validates_presence_of :title, :url, :userid
end