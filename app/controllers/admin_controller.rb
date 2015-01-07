class AdminController < ApplicationController

	def index
		@sites = Site.all
		@targets = Target.all
		@bassets = Basset.all

		
	end

end