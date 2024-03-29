class BassetsController < ApplicationController
  
  def new  
    @basset = Basset.new  
  end  
    
  def create  

    @basset = Basset.new()
    @basset.name = params[:basset][:name]
    @basset.siteid = params[:basset][:siteid]

    
    f = params[:basset][:image]

    #@site.imageinfo = f

    result = Site.upload( f.tempfile, f.original_filename)
    @basset.image = {"name" => result["name"], "__type" => "File", "url" => result["url"]}

    if @basset.save
      
      redirect_to "/sites/" + @basset.siteid.to_s , :notice => ( @basset.name + " created!" )
      #redirect_to "/sites", :notice => imageArray

    else  
    
    render "new"  
    
    end  


  end

  def edit
    @basset = Basset.find(params[:id])
    
  end


  def index
    @bassets = Basset.all
  end

  def show
    @basset = Basset.find(params[:id])

  end


end
