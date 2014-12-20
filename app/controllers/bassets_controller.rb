class BassetsController < ApplicationController
  
  def new  
    @basset = Basset.new  
  end  
    
  def create  

    @basset = Basset.new()
    @basset.name = params[:basset][:name]
    @basset.siteid = current_user.id

    
    f = params[:basset][:image]

    #@site.imageinfo = f

    result = Site.upload( f.tempfile, f.original_filename)
    @basset.image = {"name" => result["name"], "__type" => "File", "url" => result["url"]}

      if @basset.save
        
        redirect_to "/sites", :notice => ( @basset.name + " created!" )
        #redirect_to "/sites", :notice => imageArray

      else  
      
      render "new"  
    
    end  


  end

  def index
    @bassets = Basset.all
  end

  def show
    @basset = Basset.find(params[:id])

  end


end
