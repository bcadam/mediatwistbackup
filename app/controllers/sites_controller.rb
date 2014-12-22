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

        ##goes to current site and gets all of the links
        @currentimages = MetaInspector.new(@site.url)
        @currentimages = @currentimages.images

        @arrayofimageurls = []
        $i = 0
        count = 0
        while $i < @currentimages.length  do
          @arrayofimageurls.push(@currentimages[$i])
          $i +=1 
        end

        

        @site.siteassets = @test
        ##end of fetching site assets


        #takes the uploaded file and places it on Parse.com
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

        @bassets = Basset.where(:siteid => @site.id)

        @basset = Basset.new

  end

  def getpage

        @array = params[:id]
    





  end


end
