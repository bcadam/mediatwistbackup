class SitesController < ApplicationController
  def new  
    @site = Site.new  
  end  
    
  def create  
    @site = Site.new(params[:site].merge(:userid => current_user.id) )

    if @site.save
      redirect_to "/profile", :notice => "Signed up!"  
    else  
      render "new"  
    end  
  end

  def index
    @user = current_user
    @sites = Site.where(:userid => @user.id)
  end

  def show
  end

  
end
