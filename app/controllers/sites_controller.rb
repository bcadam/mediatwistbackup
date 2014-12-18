class SitesController < ApplicationController
  def new  
    @site = Site.new  
  end  
    
  def create  
    @site = Site.new(params[:site])  
    if @site.save  
      redirect_to root_url, :notice => "Signed up!"  
    else  
      render "new"  
    end  
  end

  def index
    @user = current_user
    @sites = Site.where(:userid => @user.id)
  end

end
