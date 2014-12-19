class SitesController < ApplicationController
  def new  
    @site = Site.new  
  end  
    
  def create  

    @site = Site.new()
    @site.title = params[:site][:title]
    @site.url = params[:site][:url]
    @site.body = params[:site][:body]
    @site.userid = current_user.id


    
    f = params[:site][:image]

    #@site.imageinfo = f

    result = Site.upload( f.tempfile, f.original_filename)
    @site.image = {"name" => result["name"], "__type" => "File", "url" => result["url"]}

    if @site.save
      
      redirect_to "/sites", :notice => ( @site.title + " created!" )
      #redirect_to "/sites", :notice => imageArray

    else  
      
      render "new"  
    
    end  


  end

  def index
    @user = current_user
    @sites = Site.where(:userid => @user.id)
  end

  def show
    @site = Site.find(params[:id])

  end


end
